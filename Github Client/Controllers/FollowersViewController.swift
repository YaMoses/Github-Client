//
//  FollowersViewController.swift
//  Github Client
//
//  Created by Yamoses on 09/02/2024.

import UIKit

class FollowersViewController: UIViewController {
    
    enum Section { case main }
    var userNotFoundView : UserNotFoundOverlayView!
    var username: String!
    var followers: [Follower] = []
    var currentPage = 1
    var moreUsersAvailable = true
    var followerCollectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        userNotFoundView = UserNotFoundOverlayView()
        view.addSubview(userNotFoundView)
        userNotFoundView.isHidden = true
        configureCollectionView()
        getFollowers(userName: username, page: currentPage)
        configureDataSource()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.isTranslucent = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
           let offsetY = scrollView.contentOffset.y

           if offsetY > 50 {
               // Scrolling down, hide large title
               navigationController?.navigationBar.prefersLargeTitles = false
           } else {
               // Scrolling up, show large title
               navigationController?.navigationBar.prefersLargeTitles = true
           }
    }
    
    func getFollowers(userName: String, page: Int) {
        NetworkManager.shared.getFollowers(username: userName, page: 1) { [weak self] result in
            switch result {
            case.success(let followers):
                if followers.count < 100 {
                    self?.moreUsersAvailable = false
                }
                self?.followers.append(contentsOf: followers)
                DispatchQueue.main.async {
                    self?.updateData()
                    self?.userNotFoundView.isHidden = followers.isEmpty
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }

    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        if traitCollection.userInterfaceStyle == .dark {
            appearance.backgroundColor = .systemBackground
        } else {
            appearance.backgroundColor = .systemBackground
        }
        
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        // Handle trait collection changes (e.g., switching between light and dark mode)
        configureNavigationBar()
    }
    
    func configureCollectionView() {
        followerCollectionView = UICollectionView(frame: .zero, collectionViewLayout: createFlowLayout())
        followerCollectionView.contentInsetAdjustmentBehavior = .scrollableAxes
        view.addSubview(followerCollectionView)
        followerCollectionView.delegate = self
        
        followerCollectionView.translatesAutoresizingMaskIntoConstraints = false
           NSLayoutConstraint.activate([
               followerCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
               followerCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
               followerCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
               followerCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
           ])
        
        followerCollectionView.register(FollowersCollectionViewCell.self, forCellWithReuseIdentifier: FollowersCollectionViewCell.reuseID)
    }
    
    func createFlowLayout() -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemwidth = availableWidth / 3
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemwidth, height: itemwidth + 40)
     
        return flowLayout
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: followerCollectionView, cellProvider: { (usercollectionView, indexPath, user) -> UICollectionViewCell? in
            let cell = usercollectionView.dequeueReusableCell(withReuseIdentifier: FollowersCollectionViewCell.reuseID, for: indexPath) as! FollowersCollectionViewCell
            cell.set(follower: user)
            return cell
        })
    }
                                                                             
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers, toSection: .main)
        DispatchQueue.main.async {
            self.dataSource?.apply(snapshot, animatingDifferences: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let follower = followers[indexPath.item]
        
        let detailedUserVC = DetailedUserViewController()
        detailedUserVC.selectedFollower = follower
        navigationController?.pushViewController(detailedUserVC, animated: true)
    }
}

extension FollowersViewController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("ScrollView Did End Dragging")
        
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height  = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard moreUsersAvailable else {
                return
            }
            currentPage += 1
            getFollowers(userName: username, page: currentPage)
            
            scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
        }
    }
}
