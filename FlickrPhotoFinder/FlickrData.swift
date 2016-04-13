//
//  FlickrData.swift
//  FlickrPhotoFinder
//
//  Created by cory Sturgis on 4/11/16.
//  Copyright © 2016 CorySturgis. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class FlickrData: NSObject {


    struct Keys {
        static let FLICKR_API_KEY:String = "abe116ce571462b7d98eca4b086956b6"
        static let FLICKR_URL:String = "https://api.flickr.com/services/rest/"
        static let SEARCH_METHOD:String = "flickr.photos.search"
        static let FORMAT_TYPE:String = "json"
        static let JSON_CALLBACK:Int = 1
        static let PRIVACY_FILTER:Int = 1
        static let PAGE = 15
    }

    class func searchFlickr(searchString:String, completion:(photoArray:[FlickrPhoto], searchString:String, error:NSError?)->()) {

        var photoArray: [FlickrPhoto] = []

        Alamofire.request(.GET, Keys.FLICKR_URL, parameters: ["method": Keys.SEARCH_METHOD, "api_key": Keys.FLICKR_API_KEY, "tags": searchString, "privacy_filter": Keys.PRIVACY_FILTER, "format": Keys.FORMAT_TYPE, "nojsoncallback": Keys.JSON_CALLBACK,"per_page": Keys.PAGE]).responseJSON{ response in

                switch response.result{
                case .Success:

                    if let value = response.result.value{
                        let json = JSON(value)
                        let jsonPhotoArray = json["photos"]["photo"]

                        for (_,subJson):(String, JSON) in jsonPhotoArray {

                            let flickerPhotoObject = FlickrPhoto()
                            flickerPhotoObject.farmId = subJson["farm"].int!
                            flickerPhotoObject.photoId = subJson["id"].string!
                            flickerPhotoObject.secret = subJson["secret"].string!
                            flickerPhotoObject.serverId = subJson["server"].string!

                            flickerPhotoObject.title = subJson["title"].string!

                            flickerPhotoObject.photoURL = FlickrData.URLForFlickrPhoto(flickerPhotoObject, size: "m")

                            photoArray.append(flickerPhotoObject)

                        }

                        completion(photoArray:photoArray, searchString:searchString, error:nil)
                    }

                case .Failure(let error):

                    completion(photoArray:[], searchString:searchString, error: error)
                    return

                }

            }

        }

    class func URLForFlickrPhoto(photo:FlickrPhoto, size:String)->String{

        var _size:String = size

        if _size.isEmpty{
            _size = "m"
        }

        return "https://farm\(photo.farmId).staticflickr.com/\(photo.serverId)/\(photo.photoId)_\(photo.secret).jpg"

    }

}










