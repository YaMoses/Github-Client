//
//  Extensions+UIView.swift
//  Github Client
//
//  Created by Yamoses on 22/01/2024.
//

import UIKit

extension UIView {
    func addCustomInputViewConstraints(imageView: UIImageView, textField: UITextField, button: UIButton) {
        // Apply constraints for the image view
        imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true

        // Apply constraints for the text field
        textField.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50).isActive = true
        textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50).isActive = true
        textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true

        // Apply constraints for the button
        button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 50).isActive = true
        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func addCustomInputViewConstraintsForCellItems(imageView: UIImageView, label: UILabel, padding: CGFloat) {
        imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: padding).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor).isActive = true
        
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding).isActive = true
        label.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }
}

