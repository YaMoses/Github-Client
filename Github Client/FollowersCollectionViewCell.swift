//
//  FollowersCollectionViewCell.swift
//  Github Client
//
//  Created by Yamoses on 09/02/2024.
//

import UIKit

class FollowersCollectionViewCell: UICollectionViewCell {
    static let reuseID = "UserCell"
    let userImageView = UIImageView(title: "avatar-placeholder")
    let usernameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower) {
        usernameLabel.text = follower.login
        
        //userImageView.downloadImage(from: follower.avatarUrl ?? "" )
        
        contentView.layoutIfNeeded()
        userImageView.layer.cornerRadius = userImageView.bounds.width / 2
    }
    
    private func setupUI() {
         contentView.addSubview(userImageView)
         contentView.addSubview(usernameLabel)
         let padding: CGFloat = 8
        
         NSLayoutConstraint.activate([
            
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
             userImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
             userImageView.heightAnchor.constraint(equalTo: userImageView.widthAnchor),
             
             usernameLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 12),
             usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
             usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
             usernameLabel.heightAnchor.constraint(equalToConstant: 20)
         ])
         
        userImageView.contentMode = .scaleAspectFit
        userImageView.clipsToBounds = true
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        userImageView.layer.borderWidth = 1.0
        userImageView.layer.borderColor = UIColor.white.cgColor
        usernameLabel.textAlignment = .center
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
     }
}
