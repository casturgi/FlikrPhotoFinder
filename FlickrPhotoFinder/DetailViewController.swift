//
//  DetailViewController.swift
//  FlickrPhotoFinder
//
//  Created by cory Sturgis on 4/13/16.
//  Copyright © 2016 CorySturgis. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    var image:UIImage!
    var flickerPhoto:FlickrPhoto!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageView.image = image
        self.titleLabel.text = flickerPhoto.title

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

}
