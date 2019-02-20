//
//  AlbumsViewModel.swift
//  BoldChallenge
//
//  Created by Pedro G. Branco on 15/02/19.
//  Copyright © 2019 Pedro G. Branco. All rights reserved.
//

import Foundation
import UIKit

struct AlbumsViewModel {
    let userId: Int
    let id: Int
    let title: String
    var photos = [PhotosViewModel]()
    var thumbnail: UIImage?
    
    init(albums: Albums) {
        self.userId = albums.userId
        self.id = albums.id
        self.title = albums.title
        self.thumbnail = nil
    }
}
