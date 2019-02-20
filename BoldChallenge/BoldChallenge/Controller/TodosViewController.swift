//
//  TodosViewController.swift
//  BoldChallenge
//
//  Created by Pedro G. Branco on 15/02/19.
//  Copyright © 2019 Pedro G. Branco. All rights reserved.
//

import UIKit

class TodosViewController: UIViewController {
    
    var usersViewModel: UsersViewModel!
    private var todos = [TodosViewModel]()
    private var tableView: UITableView!
    private let service = API.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAllTodosfromUser()
        self.setUpTableView()
        self.setUpNavBarTitle()
    }
    
    func getAllTodosfromUser() {
        service.fetchTodosOfUser(userId: self.usersViewModel.id) { (todos, error) in
            if let todos = todos {
                self.todos = todos.map({return TodosViewModel(todos: $0)})
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else if let error = error {
                print(error)
            } else {
                print("Unknow")
            }
        }
    }
    
}

extension TodosViewController: UITableViewDelegate, UITableViewDataSource{
    
    func setUpTableView(){
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let navBarHeight: CGFloat = (self.navigationController?.navigationBar.frame.height)!
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: barHeight+navBarHeight, width: displayWidth, height: displayHeight+navBarHeight+barHeight))
        self.tableView.register(TodosTableViewCell.self, forCellReuseIdentifier: "todosCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todosCell", for: indexPath as IndexPath) as! TodosTableViewCell
        
        let todosViewModel = self.todos[indexPath.row]
        cell.todosViewModel = todosViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension TodosViewController{
    func setUpNavBarTitle(){
        self.navigationItem.title = "Todos of" + " \(self.usersViewModel.name)"
    }
}
