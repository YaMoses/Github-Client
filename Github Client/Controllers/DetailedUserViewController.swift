//
//  DetailedUserViewController.swift
//  Github Client
//
//  Created by Yamoses on 10/02/2024.
//

import UIKit

class DetailedUserViewController: UIViewController {
    private let userRepositoryView = UserRepositoryView()
    
    var selectedFollower : Follower?
    var repo : [Repo] = []
    var user: User?
    var username = ""
        
    enum Section {
        case main
    }
    
    var tableView: UITableView!
    var dataSource: UITableViewDiffableDataSource<Section, Repo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getInfo(username: (selectedFollower?.login)!)
        getRepo(username: (selectedFollower?.login)!)
        configureTableView()
        configureDataSource()
        setupUIElements()
        navigationController?.navigationBar.prefersLargeTitles = false

    }

    func setupUIElements() {
        userRepositoryView.userImageView.downloadImage(from: selectedFollower?.avatarUrl ?? "")
        userRepositoryView.userNameLabel.text = selectedFollower?.login
    }

    private func setupUI() {
        view.backgroundColor = .systemBackground

        view.addSubview(userRepositoryView)
        
        NSLayoutConstraint.activate([
            userRepositoryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            userRepositoryView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userRepositoryView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userRepositoryView.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
        ])
        userRepositoryView.contentMode = .left
        userRepositoryView.contentMode = .top
        userRepositoryView.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func getInfo(username: String) {
        NetworkManager.shared.getUser(username: username) { [weak self] result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self?.updateUserInformation()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func getRepo(username: String) {
        NetworkManager.shared.getRepos(username: username) { [weak self] result in
            switch result {
            case .success(let repo):
                self?.updateData(with: repo)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    func configureTableView() {
        tableView = UITableView(frame: .zero , style: .plain)
        view.addSubview(tableView)
        tableView.delegate = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: userRepositoryView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
    
        tableView.register(RepoTableViewCell.self, forCellReuseIdentifier: RepoTableViewCell.reuseID)
        }
    
    func configureDataSource() {
          dataSource = UITableViewDiffableDataSource<Section, Repo>(tableView: tableView) { tableView, indexPath, model in
              let cell = tableView.dequeueReusableCell(withIdentifier: RepoTableViewCell.reuseID, for: indexPath) as! RepoTableViewCell
              cell.configure(with: model)
              return cell
          }
      }
    
    private func updateUserInformation() {
        userRepositoryView.fullNameLabel.text = user?.name
        userRepositoryView.followersLabel.text = "Followers: \(user?.followers ?? 0)"
        userRepositoryView.followingLabel.text = "Following: \(user?.following ?? 0)"}
        
    func updateData(with repo: [Repo]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Repo>()
        snapshot.appendSections([.main])
        snapshot.appendItems(repo, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
        
        self.repo = repo
    }
}

extension DetailedUserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPath = indexPath.row
        let repo = self.repo[selectedPath]
        print(repo.name ?? "")

        var baseURl = "https://github.com/"
        let owner = selectedFollower!.login
        let name = repo.name
        
        if let owner = owner {
            if let name = name {
                baseURl = baseURl+"\(owner)/\(name)"
            }
        }
       
        if let repoURL = URL(string: baseURl) {
             let webViewController = WebViewController()
             webViewController.repositoryURL = repoURL
             navigationController?.pushViewController(webViewController, animated: true)
         } else {
             print("Error: Invalid repository URL")
         }
    }
}
