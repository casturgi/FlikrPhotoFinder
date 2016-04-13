//
//  SearchFlickrViewController.swift
//  FlickrPhotoFinder
//
//  Created by cory Sturgis on 4/11/16.
//  Copyright © 2016 CorySturgis. All rights reserved.
//

import UIKit



class SearchFlickrViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!

    var picturesArray: [FlickrPhoto] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadPhotos("lakes")

    }

    func loadPhotos(searchText:String){
        FlickrData.searchFlickr(searchText) { (photoArray, searchString, error) in

            dispatch_async(dispatch_get_main_queue(), { 
                self.picturesArray = photoArray
                self.collectionView.reloadData()

            })

        }

    }

    //collectionView delegate methods

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.picturesArray.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:UICollectionViewCell = self.collectionView.dequeueReusableCellWithReuseIdentifier("CELL", forIndexPath: indexPath) as UICollectionViewCell

        let imageView:UIImageView = UIImageView()
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        cell.backgroundView = imageView

        let quene:dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

        dispatch_async(quene) {
            let searchURL:String = self.picturesArray[indexPath.row].photoURL
            let imageData:NSData = NSData(contentsOfURL: NSURL(string:searchURL)!)!
            let imagePic:UIImage = UIImage(data: imageData)!
        
            dispatch_async(dispatch_get_main_queue(), {
                imageView.image = imagePic
            })
        
        }
        
        return cell;
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    }

    //searchBar delegate methods

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.loadPhotos(searchBar.text!)

    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
