//
//  PhotosViewController.swift
//  BoldChallenge
//
//  Created by Pedro G. Branco on 16/02/19.
//  Copyright © 2019 Pedro G. Branco. All rights reserved.
//

import UIKit

class PhotosViewController: UICollectionViewController {
    
    var albumsViewModel: AlbumsViewModel!
    private var photos = [PhotosViewModel]()
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    private let itemsPerRow: CGFloat = 4
    private let service = API.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.photos = self.albumsViewModel.photos
        self.getPhotos()
        self.setUpNavBarTitle()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.albumsViewModel.photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! PhotosCollectionViewCell
        cell.imageView.image = self.photos[indexPath.row].photo
        return cell
    }
    
    func getPhotos(){
        for i in 0...self.photos.count-1{
            service.getPhoto(photoUrl: self.photos[i].url) { (image, error) in
                if let image = image {
                    self.photos[i].photo = UIImage(data: image)!
                    if i == self.photos.count-1{
                        print(self.photos)
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                        }
                    }
                }
                else if let error = error {
                    print(error)
                } else {
                    print("Unknow")
                }
            }
        }
    }
}

extension PhotosViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
}

extension PhotosViewController{
    func setUpNavBarTitle(){
        self.navigationItem.title = "Photos of" + " \(self.albumsViewModel.title)"
    }
}
