//
//  Extensions+UIView.swift
//  Github Client
//
//  Created by Yamoses on 22/01/2024.
//

import UIKit

extension UIImageView {
    convenience init(title: String) {
        self.init(image: nil)
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
        self.image = UIImage(named: title)
        //self.layer.cornerRadius = frame.width / 2
        translatesAutoresizingMaskIntoConstraints = false
    }
}

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

extension UILabel {
    convenience init(text: String, font: UIFont){
        self.init(frame: .zero)
        self.text = text
        self.font = font
        translatesAutoresizingMaskIntoConstraints = false
    }
}

extension UITextField {
    convenience init(placeholder: String? = nil) {
        self.init()
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        self.placeholder = placeholder
        minimumFontSize = 12
        adjustsFontSizeToFitWidth = true
        font = UIFont.preferredFont(forTextStyle: .title2)
        textAlignment = .center
        tintColor = .label
        textColor = .label
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        returnKeyType = .done
        translatesAutoresizingMaskIntoConstraints = false
    }
}
