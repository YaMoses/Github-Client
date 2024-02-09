//
//  SearchViewController.swift
//  Github Client
//
//  Created by Yamoses on 22/01/2024.
//

import UIKit

class SearchViewController: UIViewController {
    
    let customView = UIView()
    
    let githubLogoImageView = UIImageView(title: "gh-logo")
    let usernameTextField = UITextField(placeholder: "Enter Username")
    let searchButton = UIButton(title: "Search", backgroundColor: .systemGreen)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    private func setupUI() {
        customView.addSubview(githubLogoImageView)
        customView.addSubview(usernameTextField)
        customView.addSubview(searchButton)
        
        customView.addCustomInputViewConstraints(imageView: githubLogoImageView, textField: usernameTextField, button: searchButton)

        customView.frame = CGRect(x: 0, y: 0, width: 300, height: 400)
        customView.center = view.center
        view.addSubview(customView)
        congfigureUI()
    }
    
    private func congfigureUI() {
        usernameTextField.delegate = self
        dismissKeyboard()
        searchButton.addTarget(self, action: #selector(pushViewController), for: .touchUpInside)
    }
    
   private func dismissKeyboard() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    @objc func validateButtonTapped() {
          
      }

      private func showAlert(message: String) {
          let alert = UIAlertController(title: "Validation Error", message: message, preferredStyle: .alert)
          let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
          alert.addAction(okAction)
          present(alert, animated: true, completion: nil)
      }
    
    @objc func pushViewController() {
        if !usernameTextField.isNotEmpty() {
           showAlert(message: "Text field cannot be empty")
            return
        }

        // Validation passed
        let followerViewController = FollowersViewController()
        followerViewController.username = usernameTextField.text
       // followerViewController.title = usernameTextField.text
        navigationController?.pushViewController(followerViewController, animated: true)
    }
}


extension SearchViewController: UITextFieldDelegate {
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushViewController()
        return true
    }
}

