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

}
