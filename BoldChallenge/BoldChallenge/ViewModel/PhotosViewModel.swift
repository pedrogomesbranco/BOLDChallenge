//
//  PhotosViewModel.swift
//  BoldChallenge
//
//  Created by Pedro G. Branco on 16/02/19.
//  Copyright © 2019 Pedro G. Branco. All rights reserved.
//

import Foundation
import UIKit

struct PhotosViewModel {
    let albumId: Int
    let id: Int
    let title: String
    let url: URL
    let thumbnailUrl: URL
    var photo: UIImage!
    
    init(photos: Photos) {
        self.albumId = photos.albumId
        self.id = photos.id
        self.title = photos.title
        self.url = photos.url
        self.thumbnailUrl = photos.thumbnailUrl
    }
}
