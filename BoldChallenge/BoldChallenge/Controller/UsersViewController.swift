//
//  UsersViewController.swift
//  BoldChallenge
//
//  Created by Pedro G. Branco on 13/02/19.
//  Copyright © 2019 Pedro G. Branco. All rights reserved.
//

import UIKit

class UsersViewController: UIViewController {
    
    private var usersViewModel = [UsersViewModel]()
    private var tableView: UITableView!
    private var actionIndicator: CustomActionIndicator!
    private let service = API.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        self.actionIndicator = CustomActionIndicator(frame: self.view.bounds)
        self.getAllUsers()
        self.setUpTableView()
        self.setUpNavBarTitle()
    }
    
    func getAllUsers() {
        self.actionIndicator.show(on: self.view)
        service.fetchUsers{ (user, error) in
            if let user = user {
                self.usersViewModel = user.map({return UsersViewModel(user: $0)})
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

extension UsersViewController: UITableViewDelegate, UITableViewDataSource{
    
    func setUpTableView(){
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        self.tableView.register(UsersTableViewCell.self, forCellReuseIdentifier: "userCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.usersViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath as IndexPath) as! UsersTableViewCell
        let usersViewModel = self.usersViewModel[indexPath.row]
        cell.usersViewModel = usersViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("\(usersViewModel[indexPath.row].id)" + " - " +  "\(usersViewModel[indexPath.row].name)")
        
        let nextController = UserOptionsViewController(nibName: "UserOptionsViewController", bundle: nil)
        nextController.usersViewModel = self.usersViewModel[indexPath.row]
        
        navigationController?.pushViewController(nextController, animated: true)
    }
}

extension UsersViewController{
    
    func setUpNavBarTitle(){
        self.navigationItem.title = "Users"
    }
}
