//
//  Ext+Label.swift
//  Github Client
//
//  Created by Yamoses on 20/02/2024.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont){
        self.init(frame: .zero)
        self.text = text
        self.font = font
        translatesAutoresizingMaskIntoConstraints = false
    }
}
