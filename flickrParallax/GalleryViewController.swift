//
//  GalleryViewController.swift
//  flickrParallax
//
//  Created by Mavericks on 19/11/15.
//  Copyright © 2015 Mavericks. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var searchTerm: String!
    var flickrResults: NSMutableArray!
    
    var x: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        
        loadPhotos()
    }
    
    func loadPhotos(){
        print("x")
        let flickr: FlickrHelper = FlickrHelper()
        flickr.searchFlickrForString(searchTerm) { (searchStr, flickrPhotos, error) -> () in
            
          //  if error == nil {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    print(flickrPhotos)
                    self.flickrResults = flickrPhotos
                    self.x = 1
                    self.collectionView.reloadData()
                })
            //}
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCellWithReuseIdentifier("myCell", forIndexPath: indexPath) as! FlickrCollectionViewCell
        
        cell.image = nil
        
        let queue: dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        
        
        if (x == 1){

        dispatch_async(queue ,{ () -> Void in
            //var error: NSError?
            
            let searchURL: String = self.flickrResults.objectAtIndex(indexPath.item) as! String
            let imgData = NSData(contentsOfURL: NSURL(string: searchURL)!)
            print("run1")
            let image: UIImage = UIImage(data: imgData!)!
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                cell.image = image
                
                let yOffset:CGFloat = ((self.collectionView.contentOffset.y - cell.frame.origin.y) / 200 )*25
                
                cell.imgOffset = CGPointMake(0, yOffset)
                
            })
        })
        }
        return cell
            }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        for view in collectionView.visibleCells() {
            let cell: FlickrCollectionViewCell = view as! FlickrCollectionViewCell
            let yOffset:CGFloat = ((self.collectionView.contentOffset.y - cell.frame.origin.y) / 200 )*25
            
            cell.setImageOffset(CGPointMake(0, yOffset))
        }
    }
    
}
