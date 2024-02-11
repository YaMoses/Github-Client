//
//  WebViewController.swift
//  Github Client
//
//  Created by Yamoses on 11/02/2024.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    var repositoryURL: URL?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let url = repositoryURL {
        let webView = WKWebView(frame: view.bounds)
        view.addSubview(webView)

        let request = URLRequest(url: url)
            webView.load(request)
        } else {
            print("Error: Repository URL is nil")
        }
    }
}
