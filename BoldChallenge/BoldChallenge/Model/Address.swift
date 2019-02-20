//
//  Address.swift
//  BoldChallenge
//
//  Created by Pedro G. Branco on 13/02/19.
//  Copyright © 2019 Pedro G. Branco. All rights reserved.
//

import Foundation

struct Address: Decodable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
}
