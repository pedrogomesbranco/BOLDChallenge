//
//  UsersViewModel.swift
//  BoldChallenge
//
//  Created by Pedro G. Branco on 14/02/19.
//  Copyright © 2019 Pedro G. Branco. All rights reserved.
//

import Foundation

struct UsersViewModel {
    
    let name: String
    let id: Int
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
    
    init(user: User) {
        self.name = user.name
        self.id = user.id
        self.username = user.username
        self.email = user.email
        self.address = user.address
        self.phone = user.phone
        self.website = user.website
        self.company = user.company
    }
}
