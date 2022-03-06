//
//  LoginWebViewController.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-03-06.
//

import UIKit
import WebKit

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
        
        
        let codeResponse = loginManager.extractCode(url: url)
        
        switch codeResponse {
        case .success(let code):
            Task {
                do {
                    let response = try await loginManager.tradeCodeForToken(with: code)
                    // Todo: Refactor all userdefaults keys into an enum
                    UserDefaults.standard.set(OnboardingStatus.loggedIn.rawValue, forKey: OnboardingStatus.userDefaultsKey)
                    UserDefaults.standard.set(response.accessToken, forKey: TokenConstants.accessTokenKey)
                    UserDefaults.standard.set(response.refreshToken, forKey: TokenConstants.refreshTokenKey)
                    UserDefaults.standard.set(response.expiresIn + Int(Date().timeIntervalSince1970),
                                              forKey: TokenConstants.expiryDateKey)
                    self.dismiss(animated: true)
                    
                } catch is NetworkError {
                    print("is Network Error")
                } catch {
                    print("is another type of error")
                }
            }
            
        case .failure(let err):
            switch err {
            case .noItems:
                print("no items")
            case .accessDenied:
                print("access denied")
            case .noCode:
                print("no code")
            }
        }
        
    
    }
}
