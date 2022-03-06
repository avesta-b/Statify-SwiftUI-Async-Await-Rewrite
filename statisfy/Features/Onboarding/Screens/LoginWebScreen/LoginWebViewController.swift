//
//  LoginWebViewController.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-03-06.
//

import UIKit

final class LoginWebViewController: UIViewController {
    
    private let loginManager: LoginManager
    
    init(loginManager: LoginManager) {
        self.loginManager = loginManager
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable, message: "Use init(loginURLGenerator instead")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let webView: WKWebView = {
        let config = WKWebViewConfiguration()
        config.applicationNameForUserAgent = "Version/8.0.2 Safari/600.2.5"
        config.defaultWebpagePreferences.allowsContentJavaScript = true
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configure()
        loadWebView()
    }
    
    private func loadWebView() {
        webView.navigationDelegate = self
        let request = loginManager.loginRequest
        webView.load(request)
    }
    
    private func configure() {
        view.addSubview(webView)
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            webView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}

extension LoginWebViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        guard let url = webView.url else {
            return
        }
        
        let code = loginManager.extractCode(url: url)
    }
}
