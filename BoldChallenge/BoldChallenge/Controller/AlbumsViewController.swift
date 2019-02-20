//
//  AlbumsViewController.swift
//  BoldChallenge
//
//  Created by Pedro G. Branco on 15/02/19.
//  Copyright © 2019 Pedro G. Branco. All rights reserved.
//

import UIKit

class AlbumsViewController: UIViewController {
    
    var usersViewModel: UsersViewModel!
    private var albums = [AlbumsViewModel]()
    private var photos = [PhotosViewModel]()
    private var tableView: UITableView!
    private var actionIndicator: CustomActionIndicator!
    private let service = API.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.actionIndicator = CustomActionIndicator(frame: self.view.bounds)
        self.getAllAlbumsfromUser()
        self.setUpTableView()
        self.setUpNavBarTitle()
    }
    
    func getAllAlbumsfromUser() {
        self.actionIndicator.show(on: self.view)
        service.fetchAlbumsOfUser(userId: self.usersViewModel.id) { (albums, error) in
            if let albums = albums {
                self.albums = albums.map({return AlbumsViewModel(albums: $0)})
                for i in 1...self.albums.count{
                    self.getPhotosFromAlbum(albumId: i)
                }
            } else if let error = error {
                print(error)
            } else {
                print("Unknow")
            }
        }
    }
    
    func getPhotosFromAlbum(albumId: Int){
        service.fetchPhotosOfAlbum(albumId: albumId) { (photos, error) in
            if let photos = photos {
                let photosViewModel = photos.map({return PhotosViewModel(photos: $0)})
                self.albums[albumId-1].photos = photosViewModel
                self.getThumbnail(url: self.albums[albumId-1].photos[0].thumbnailUrl, albumId: albumId-1)
            } else if let error = error {
                print(error)
            } else {
                print("Unknow")
            }
        }
    }
    
    func getThumbnail(url: URL, albumId: Int){
        service.getPhoto(photoUrl: url) { (image, error) in
            if let image = image {
                self.albums[albumId].thumbnail = UIImage(data: image)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.actionIndicator.hide()
                }
            } else if let error = error {
                print(error)
            } else {
                print("Unknow")
            }
        }
    }
}

extension AlbumsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func setUpTableView(){
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let navBarHeight: CGFloat = (self.navigationController?.navigationBar.frame.height)!
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: barHeight+navBarHeight, width: displayWidth, height: displayHeight+navBarHeight+barHeight))
        self.tableView.register(AlbumsTableViewCell.self, forCellReuseIdentifier: "AlbumsCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumsCell", for: indexPath as IndexPath) as! AlbumsTableViewCell
        
        let albumsViewModel = self.albums[indexPath.row]
        cell.albumsViewModel = albumsViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let nextController = PhotosCollectionViewController(nibName: "PhotosCollectionViewController", bundle: nil)
        nextController.albumsViewModel = self.albums[indexPath.row]
        navigationController?.pushViewController(nextController, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension AlbumsViewController{
    func setUpNavBarTitle(){
        self.navigationItem.title = "Albums of" + " \(self.usersViewModel.name)"
    }
}
