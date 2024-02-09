//
//  Helper.swift
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

//extension UIImageView {
//    func downloadImage (from urlString: String) {
//        let cache = NetworkManager.shared.cache
//        let cacheKey = NSString(string: urlString)
//        
//        if let image = cache.object(forKey: cacheKey){
//            self.image = image
//            return
//        }
//        
//        guard let url = URL(string: urlString) else { return }
//        
//        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
//            guard let self = self else { return }
//            if error != nil { return }
//                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
//                guard let data = data else { return }
//                guard let image = UIImage(data: data) else { return }
//                
//            guard let image = UIImage(data: data) else { return }
//            cache.setObject(image, forKey: cacheKey)
//            
//            DispatchQueue.main.async {
//                self.image = image
//            }
//        }
//        task.resume()
//    }
//}

extension UITextField {
    // Validate non-empty text
    func isNotEmpty() -> Bool {
        guard let text = self.text else { return false }
        return !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
