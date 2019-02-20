//
//  CustomActionIndicator.swift
//  BoldChallenge
//
//  Created by Pedro G. Branco on 17/02/19.
//  Copyright © 2019 Pedro G. Branco. All rights reserved.
//

import UIKit

class CustomActionIndicator: UIActivityIndicatorView {
    
    private var parentView: UIView!
    private var backgroundView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        backgroundView.backgroundColor = UIColor.gray.withAlphaComponent(0.7)
        backgroundView.clipsToBounds = true
        backgroundView.layer.cornerRadius = 10
        
        self.style = .whiteLarge
        self.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        self.center = CGPoint(x: backgroundView.frame.size.width/2,
                              y: backgroundView.frame.size.height/2)
        
        backgroundView.addSubview(self)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(on view: UIView) {
        self.parentView = view
        
        if backgroundView.superview == nil {
            backgroundView.center = view.center
            backgroundView.addSubview(self)
            view.addSubview(backgroundView)
        }
        
        view.isUserInteractionEnabled = false
        self.startAnimating()
    }
    
    func hide() {
        if self.parentView != nil {
            self.parentView.isUserInteractionEnabled = true
        }
        self.stopAnimating()
        self.backgroundView.removeFromSuperview()
    }
    
}
