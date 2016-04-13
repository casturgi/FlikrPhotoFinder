//
//  FlickrPhoto.swift
//  FlickrPhotoFinder
//
//  Created by cory Sturgis on 4/11/16.
//  Copyright © 2016 CorySturgis. All rights reserved.
//

import UIKit

class FlickrPhoto: NSObject {


    var farmId:Int = 0
    var photoId:String = ""
    var secret:String = ""
    var serverId:String = ""

    var title:String = ""
    var photoURL:String = ""

    var image:UIImage!

    override init() {
        
    }
}
