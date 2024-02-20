//
//  Ext+Button.swift
//  Github Client
//
//  Created by Yamoses on 20/02/2024.
//

import UIKit

extension UIButton {
    convenience init(title: String, backgroundColor: UIColor){
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.layer.cornerRadius = 10
        self.backgroundColor = backgroundColor
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
