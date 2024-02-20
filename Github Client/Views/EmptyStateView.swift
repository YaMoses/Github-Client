//
//  UserNotFoundOverlayView.swift
//  Github Client
//
//  Created by Yamoses on 14/02/2024.
//

import UIKit

class EmptyStateView: UIView {

        private let imageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "gh-logo")
            imageView.contentMode = .scaleAspectFit
            imageView.translatesAutoresizingMaskIntoConstraints = false
            return imageView
        }()

        private let okButton: UIButton = {
            let button = UIButton()
            button.setTitle("OK", for: .normal)
            button.backgroundColor = .systemBlue
            button.addTarget(EmptyStateView.self, action: #selector(okButtonTapped), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()

        override init(frame: CGRect) {
            super.init(frame: frame)
            setupUI()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        private func setupUI() {
            backgroundColor = .white

            addSubview(imageView)
            addSubview(okButton)

            NSLayoutConstraint.activate([
                imageView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
                imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
                imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
                imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),

                okButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
                okButton.centerXAnchor.constraint(equalTo: centerXAnchor),
                okButton.widthAnchor.constraint(equalToConstant: 100),
                okButton.heightAnchor.constraint(equalToConstant: 40),
            ])
        }

        @objc private func okButtonTapped() {
            removeFromSuperview()
        }
}



