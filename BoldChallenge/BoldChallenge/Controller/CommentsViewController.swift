//
//  CommentsViewController.swift
//  BoldChallenge
//
//  Created by Pedro G. Branco on 15/02/19.
//  Copyright © 2019 Pedro G. Branco. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {
    
    var postViewModel: PostsViewModel!
    private var comments = [CommentsViewModel]()
    private var tableView: UITableView!
    private let service = API.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAllCommentsFromPost()
        self.setUpTableView()
        self.setUpNavBarTitle()
    }
    
    func getAllCommentsFromPost() {
        service.fetchCommentsOfPost(postId: self.postViewModel.id) { (comments, error) in
            if let comments = comments {
                self.comments = comments.map({return CommentsViewModel(comments: $0)})
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

extension CommentsViewController: UITableViewDelegate, UITableViewDataSource{
    
    func setUpTableView(){
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let navBarHeight: CGFloat = (self.navigationController?.navigationBar.frame.height)!
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        self.tableView = UITableView(frame: CGRect(x: 0, y: barHeight+navBarHeight, width: displayWidth, height: displayHeight+navBarHeight+barHeight))
        self.tableView.register(CommentsTableViewCell.self, forCellReuseIdentifier: "commentssCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentssCell", for: indexPath as IndexPath) as! CommentsTableViewCell
        
        let commentsViewModel = self.comments[indexPath.row]
        cell.commentsViewModel = commentsViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.white
        let headerLaber = UILabel(frame: self.tableView.rectForHeader(inSection: 0))
        headerLaber.textAlignment = .center
        headerLaber.adjustsFontSizeToFitWidth = true
        headerLaber.adjustsFontForContentSizeCategory = true
        headerLaber.numberOfLines = 10
        headerLaber.font = UIFont.systemFont(ofSize: 18)
        headerLaber.text = self.postViewModel.body
        headerView.addSubview(headerLaber)
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.postViewModel.body.height(withConstrainedWidth: self.view.frame.width, font: UIFont.systemFont(ofSize: 18))
    }
}

extension CommentsViewController{
    func setUpNavBarTitle(){
        self.navigationItem.title = self.postViewModel.title
    }
}

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}
