//
//  UserOptionsViewController.swift
//  BoldChallenge
//
//  Created by Pedro G. Branco on 15/02/19.
//  Copyright © 2019 Pedro G. Branco. All rights reserved.
//

import UIKit

class UserOptionsViewController: UIViewController {
    
    var usersViewModel: UsersViewModel!
    private var options = ["Albums", "Posts", "Todos"]
    private var tableView: UITableView!
    private let service = API.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpTableView()
        self.setUpNavBarTitle()
    }
}

extension UserOptionsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func setUpTableView(){
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let navBarHeight: CGFloat = (self.navigationController?.navigationBar.frame.height)!
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: barHeight+navBarHeight, width: displayWidth, height: displayHeight+navBarHeight+barHeight))
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "userCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath as IndexPath)
        cell.textLabel!.text = self.options[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
        switch indexPath.row {
        case 0:
            let nextController = AlbumsViewController(nibName: "AlbumsViewController", bundle: nil)
            nextController.usersViewModel = self.usersViewModel
            navigationController?.pushViewController(nextController, animated: true)
        case 1:
            let nextController = PostsViewController(nibName: "PostsViewController", bundle: nil)
            nextController.usersViewModel = self.usersViewModel
            navigationController?.pushViewController(nextController, animated: true)
        default:
            let nextController = TodosViewController(nibName: "TodosViewController", bundle: nil)
            nextController.usersViewModel = self.usersViewModel
            navigationController?.pushViewController(nextController, animated: true)
        }
    }
}

extension UserOptionsViewController{
    func setUpNavBarTitle(){
        self.navigationItem.title = self.usersViewModel.name
    }
}
