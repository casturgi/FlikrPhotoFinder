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
    var activityIndicator:UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        self.activityIndicator.hidesWhenStopped = true
        view.addSubview(self.activityIndicator)
        self.activityIndicator.startAnimating()

        let activityBBItem:UIBarButtonItem = UIBarButtonItem(customView: self.activityIndicator)
        self.navigationItem.setRightBarButtonItem(activityBBItem, animated: true)



        self.loadFlickrPhotoData("lakes")

    }

    func loadFlickrPhotoData(searchText:String){
        FlickrData.searchFlickr(searchText) { (photoArray, searchString, error) in

            let quene:dispatch_queue_t = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

            dispatch_async(quene) {

                for flickrPhoto:FlickrPhoto in photoArray{
                    let searchURL:String = flickrPhoto.photoURL
                    let imageData:NSData = NSData(contentsOfURL: NSURL(string:searchURL)!)!
                    flickrPhoto.image = UIImage(data: imageData)!
                }

                dispatch_async(dispatch_get_main_queue(), {
                    self.picturesArray = photoArray
                    self.collectionView.reloadData()
                    self.activityIndicator.stopAnimating()
                })
                
            }

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
        imageView.image = self.picturesArray[indexPath.row].image

        cell.backgroundView = imageView

        
        return cell;
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    }

    //searchBar delegate methods

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.activityIndicator.startAnimating()
        self.loadFlickrPhotoData(searchBar.text!)

    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //segue methods

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let dvc:DetailViewController = segue.destinationViewController as! DetailViewController
        let indexPath = self.collectionView.indexPathForCell(sender as! UICollectionViewCell)

        dvc.image = self.picturesArray[(indexPath?.row)!].image
        dvc.flickerPhoto = self.picturesArray[(indexPath?.row)!]
        

    }


}
