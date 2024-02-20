//
//  Ext+TextField.swift
//  Github Client
//
//  Created by Yamoses on 20/02/2024.
//

import UIKit

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

extension UITextField {
    // Validate non-empty text
    func isNotEmpty() -> Bool {
        guard let text = self.text else { return false }
        return !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
