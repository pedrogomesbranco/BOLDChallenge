//
//  Comments.swift
//  BoldChallenge
//
//  Created by Pedro G. Branco on 13/02/19.
//  Copyright © 2019 Pedro G. Branco. All rights reserved.
//

import Foundation

struct Comments: Decodable {
    let postId: Int
    let id: Int
    let name: String
    let email: String
    let body: String
    
    
}
