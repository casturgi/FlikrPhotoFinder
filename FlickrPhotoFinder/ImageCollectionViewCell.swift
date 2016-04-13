//
//  ImageCollectionViewCell.swift
//  FlickrPhotoFinder
//
//  Created by cory Sturgis on 4/13/16.
//  Copyright © 2016 CorySturgis. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {

    var imageView:UIImageView!
    var image:UIImage!{

        get{
            return self.image
        }

        set{
            self.imageView.image = newValue

            if pointOffset != nil {
                setImageOffset(pointOffset)
            } else{
                setImageOffset(CGPointMake(0, 0))
            }
        }
    }

    var pointOffset:CGPoint!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpImageView()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setUpImageView()
    }

    func setUpImageView(){

        self.clipsToBounds = true

        imageView = UIImageView(frame: CGRectMake(self.bounds.origin.x, self.bounds.origin.y, 600, 200))
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = false
        self.addSubview(imageView)

    }

    func setImageOffset(imageOffset:CGPoint){

        self.pointOffset = imageOffset

        let frame:CGRect = imageView.bounds
        let offsetFrame:CGRect = CGRectOffset(frame, self.pointOffset.x, self.pointOffset.y)
        imageView.frame = offsetFrame

    }










}
