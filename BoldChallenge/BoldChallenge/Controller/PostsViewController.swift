//
//  PostsViewController.swift
//  BoldChallenge
//
//  Created by Pedro G. Branco on 15/02/19.
//  Copyright © 2019 Pedro G. Branco. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {
    
    var usersViewModel: UsersViewModel!
    private var posts = [PostsViewModel]()
    private var tableView: UITableView!
    private var actionIndicator: CustomActionIndicator!
    private let service = API.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.actionIndicator = CustomActionIndicator(frame: self.view.bounds)
        self.getAllPostsfromUser()
        self.setUpTableView()
        self.setUpNavBarTitle()
    }
    
    func getAllPostsfromUser() {
        self.actionIndicator.show(on: self.view)
        service.fetchPostsOfUser(userId: self.usersViewModel.id) { (posts, error) in
            if let posts = posts {
                self.posts = posts.map({return PostsViewModel(posts: $0)})
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

extension PostsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func setUpTableView(){
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let navBarHeight: CGFloat = (self.navigationController?.navigationBar.frame.height)!
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: barHeight+navBarHeight, width: displayWidth, height: displayHeight+navBarHeight+barHeight))
        self.tableView.register(PostsTableViewCell.self, forCellReuseIdentifier: "postsCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postsCell", for: indexPath as IndexPath) as! PostsTableViewCell
        
        let postsViewModel = self.posts[indexPath.row]
        cell.postsViewModel = postsViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let nextController = CommentsViewController(nibName: "CommentsViewController", bundle: nil)
        nextController.postViewModel = self.posts[indexPath.row]
        navigationController?.pushViewController(nextController, animated: true)
        
    }
}

extension PostsViewController{
    func setUpNavBarTitle(){
        self.navigationItem.title = "Posts of" + " \(self.usersViewModel.name)"
    }
}
