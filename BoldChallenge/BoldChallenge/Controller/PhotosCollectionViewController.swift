//
//  PhotosCollectionViewController.swift
//  BoldChallenge
//
//  Created by Pedro G. Branco on 17/02/19.
//  Copyright © 2019 Pedro G. Branco. All rights reserved.
//

import UIKit

import UIKit

class PhotosCollectionViewController: UICollectionViewController {
    
    var albumsViewModel: AlbumsViewModel!
    private var photos = [PhotosViewModel]()
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    var itemsPerRow: CGFloat = 1
    private let service = API.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.photos = self.albumsViewModel.photos
        self.collectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "collectionCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.backgroundColor = .white
        self.getPhotos()
        self.setUpNavBarTitle()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.albumsViewModel.photos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! PhotoCollectionViewCell
        cell.photo.image = self.photos[indexPath.row].photo
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

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout{
    
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

extension PhotosCollectionViewController{
    func setUpNavBarTitle(){
        self.navigationItem.title = "Photos of" + " \(self.albumsViewModel.title)"

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(PhotosCollectionViewController.addTapped))
    }
    
    @objc func addTapped(){
        if self.itemsPerRow == CGFloat(1){
            self.itemsPerRow = CGFloat(2)
            self.collectionView.reloadData()
        } else if self.itemsPerRow == CGFloat(2){
            self.itemsPerRow = CGFloat(3)
            self.collectionView.reloadData()
        } else{
            self.itemsPerRow = CGFloat(1)
            self.collectionView.reloadData()
        }
    }
}
