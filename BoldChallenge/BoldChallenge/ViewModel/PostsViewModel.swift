//
//  PostsViewModel.swift
//  BoldChallenge
//
//  Created by Pedro G. Branco on 15/02/19.
//  Copyright © 2019 Pedro G. Branco. All rights reserved.
//

import Foundation

struct PostsViewModel {
    let userId: Int
    let id: Int
    let title: String
    let body: String
    
    init(posts: Posts) {
        self.userId = posts.userId
        self.id = posts.id
        self.title = posts.title
        self.body = posts.body
    }
}
