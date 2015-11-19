//
//  FlickrCollectionViewCell.swift
//  flickrParallax
//
//  Created by Mavericks on 19/11/15.
//  Copyright © 2015 Mavericks. All rights reserved.
//

import UIKit

class FlickrCollectionViewCell: UICollectionViewCell {
    var imageView: UIImageView!
    var image: UIImage! {
        get{
            return self.image
        }
        
        set{
            self.imageView.image = newValue
            if imgOffset != nil {
                setImageOffset(imgOffset)
            }else {
                setImageOffset(CGPointMake(0, 0))
            }
            
        }
    }
    
    var imgOffset: CGPoint!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupImageView()
    }
    
    func setupImageView(){
        self.clipsToBounds = true
        
        imageView = UIImageView(frame: CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: 375, height: 200))
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = false
        
        self.addSubview(imageView)
    }
    
    func setImageOffset(imageOffset: CGPoint) {
        self.imgOffset = imageOffset
        
        let frame: CGRect = self.imageView.bounds
        let offsetFrame: CGRect = CGRectOffset(frame, self.imgOffset.x, self.imgOffset.y)
        imageView.frame = offsetFrame
    }
}
