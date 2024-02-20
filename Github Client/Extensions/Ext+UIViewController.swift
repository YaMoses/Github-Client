//
//  Ext+UIViewController.swift
//  Github Client
//
//  Created by Yamoses on 20/02/2024.
//

import UIKit

extension UIViewController {
    
    func showEmptyStateView(in view: UIView) {
        let emptyStateView = EmptyStateView()
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
    //MARK: To DO
    func presentAlertonMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            
        }
    }
    
    func showLoadingView() {
        
    }
    
    func dismisLoadingView() {
        
    }
    
    
}
