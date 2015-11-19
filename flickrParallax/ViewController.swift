//
//  ViewController.swift
//  flickrParallax
//
//  Created by Mavericks on 19/11/15.
//  Copyright © 2015 Mavericks. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var imageView: UIImageView!
    
    var step:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        searchBar.becomeFirstResponder()
        searchBar.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        UIView.animateWithDuration(0.4, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
            if self.step == 0 {
                self.imageView.transform = CGAffineTransformMakeScale(1.09, 1.09)
                self.step = 1
            }else {
                self.imageView.transform = CGAffineTransformIdentity
                self.step = 0
            }
            
            }, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destinationViewController: GalleryViewController = segue.destinationViewController as! GalleryViewController
        
        if (searchBar.text != nil) {
            destinationViewController.searchTerm = searchBar.text
        }else {
            let alert = UIAlertController(title: "Oops", message: "Please enter a search term", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }


}

