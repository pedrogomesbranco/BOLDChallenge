//
//  UsersTableViewCell.swift
//  BoldChallenge
//
//  Created by Pedro G. Branco on 15/02/19.
//  Copyright © 2019 Pedro G. Branco. All rights reserved.
//

import UIKit

class UsersTableViewCell: UITableViewCell {

    var usersViewModel: UsersViewModel! {
        didSet{
            textLabel?.text = usersViewModel.name
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        textLabel?.numberOfLines = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
