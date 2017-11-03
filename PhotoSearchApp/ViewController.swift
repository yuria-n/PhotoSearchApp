//
//  ViewController.swift
//  PhotoSearchApp
//
//  Created by Julia on 2017/11/02.
//  Copyright © 2017 Julia. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {
    var keyword: String = "apple"
    var photos: [Photo] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    @IBAction func searchButton(_ sender: UIButton) {
        self.photos = []
        keyword = searchTextField.text!
        loadColectionView(keyword: keyword)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Photos"
        
        loadColectionView(keyword: keyword)
    }
    
    // Load or update collection view
    func loadColectionView(keyword: String) {
        FlickrAPI.getPhotos(keyword: keyword) { (photos) in
            self.photos = photos
            self.collectionView.reloadData()
            
            // Reset scroll
            self.collectionView.contentOffset = CGPoint(x: 0, y: 0)
        }
    }
    
    // Number of sections
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // Number of cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    // Display each cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CustomCell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath)
            as! CustomCell
        
        let photo = photos[indexPath.row]
        
        // title
        cell.titleLabel.text = photo.title
        
        // imageView
        cell.imageView.image = UIImage(named: "no_image.png")
        let url = URL(string: Generaters.generateImageUrl(photo: photo, size: "q"))
        if url != nil {
            let data = try? Data(contentsOf: url!)
            cell.imageView.image = UIImage(data: data!)!
        }
        
        return cell
    }
}
