//
//  RepoTableViewCell.swift
//  Github Client
//
//  Created by Yamoses on 11/02/2024.
//

import UIKit

class RepoTableViewCell: UITableViewCell {
    static let reuseID = "UserCell"

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let languageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let starsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .orange
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with repository: Repo) {
        nameLabel.text = repository.name
        languageLabel.text = repository.language
        starsLabel.text = "Stars: \(repository.stargazersCount ?? 0)"
        descriptionLabel.text = repository.description
    }

    private func setupUI() {
        addSubview(nameLabel)
        addSubview(languageLabel)
        addSubview(starsLabel)
        addSubview(descriptionLabel)

        let padding: CGFloat = 8

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),

            languageLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: padding),
            languageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            languageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),

            starsLabel.topAnchor.constraint(equalTo: languageLabel.bottomAnchor, constant: padding),
            starsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            starsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),

            descriptionLabel.topAnchor.constraint(equalTo: starsLabel.bottomAnchor, constant: padding),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            descriptionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding)
        ])
    }
}
