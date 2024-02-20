//
//  Ext+UIImageView.swift
//  Github Client
//
//  Created by Yamoses on 20/02/2024.
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

extension UIImageView {
    func downloadImage (from urlString: String) {
        let cache = NetworkManager.shared.cache
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey){
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if error != nil { return }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
                guard let data = data else { return }
                guard let _ = UIImage(data: data) else { return }
                
            guard let image = UIImage(data: data) else { return }
            cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}
