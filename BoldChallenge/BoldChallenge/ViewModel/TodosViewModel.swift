//
//  TodosViewModel.swift
//  BoldChallenge
//
//  Created by Pedro G. Branco on 15/02/19.
//  Copyright © 2019 Pedro G. Branco. All rights reserved.
//

import Foundation

struct TodosViewModel {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
    let state: String
    
    init(todos: Todos) {
        self.userId = todos.userId
        self.id = todos.id
        self.title = todos.title
        self.completed = todos.completed
        
        if self.completed{
            self.state = "Done"
        } else{
            self.state = "Not done"
        }
    }
}
