//
//  CommentsViewModel.swift
//  BoldChallenge
//
//  Created by Pedro G. Branco on 15/02/19.
//  Copyright © 2019 Pedro G. Branco. All rights reserved.
//

import Foundation

struct CommentsViewModel {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
    
    init(comments: Comments) {
        self.postId = comments.postId
        self.id = comments.id
        self.name = comments.name
        self.email = comments.email
        self.body = comments.body
    }
}
