//
//  UserRepositoryView.swift
//  Github Client
//
//  Created by Yamoses on 10/02/2024.
//

import UIKit

class UserRepositoryView: UIView {
    let userImageView: UIImageView = {
       let imageView = UIImageView()
       imageView.translatesAutoresizingMaskIntoConstraints = false
       imageView.contentMode = .scaleAspectFill
       imageView.layer.cornerRadius = 50
       imageView.clipsToBounds = true
       return imageView
   }()
   
    let userNameLabel: UILabel = {
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.font = UIFont.systemFont(ofSize: 14)
       label.textAlignment = .center
       label.textColor = .gray
       return label
   }()
   
    let fullNameLabel: UILabel = {
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.textColor = .gray
       label.textAlignment = .center
       label.font = UIFont.boldSystemFont(ofSize: 18)
       return label
   }()
   
    let followersLabel: UILabel = {
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.textColor = .gray
       label.font = UIFont.boldSystemFont(ofSize: 18)

       return label
   }()
   
    let followingLabel: UILabel = {
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
       label.textColor = .gray
       label.font = UIFont.boldSystemFont(ofSize: 18)
       return label
   }()
   
   let repositoryLabel: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.textColor = .gray
      label.font = UIFont.boldSystemFont(ofSize: 25)
      label.textAlignment = .center
      label.text = "Repos"
      return label
  }()
   
   
   let ffStackView: UIStackView = {
       let stackView = UIStackView()
       stackView.axis = .horizontal
       stackView.alignment = .center
       stackView.distribution = .equalSpacing
       stackView.translatesAutoresizingMaskIntoConstraints = false
       return stackView
   }()
   
   override init(frame: CGRect) {
       super.init(frame: frame)
       setupUI()
   }
   
   required init?(coder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
       
   private func setupUI() {
       addSubview(userImageView)
       addSubview(userNameLabel)
       addSubview(fullNameLabel)
       ffStackView.addArrangedSubview(followersLabel)
       ffStackView.addArrangedSubview(followingLabel)
       addSubview(ffStackView)
       addSubview(repositoryLabel)
       
       NSLayoutConstraint.activate([
           userImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
           userImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
           userImageView.widthAnchor.constraint(equalToConstant: 100),
           userImageView.heightAnchor.constraint(equalToConstant: 100),
           
           fullNameLabel.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 8),
           fullNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
           fullNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
           fullNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
       
           userNameLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 8),
           userNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
           userNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
           userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
       
           ffStackView.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8),
           ffStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
           ffStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
           
           repositoryLabel.topAnchor.constraint(equalTo: ffStackView.bottomAnchor, constant: 8),
           repositoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
           repositoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
           
       ])
   }
}
