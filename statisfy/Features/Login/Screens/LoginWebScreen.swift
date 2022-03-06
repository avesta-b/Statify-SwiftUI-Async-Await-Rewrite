//
//  LoginWebScreen.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-03-06.
//

import SwiftUI

struct LoginWebScreen: UIViewControllerRepresentable {
    typealias UIViewControllerType = LoginWebViewController
    
    func makeUIViewController(context: Context) -> LoginWebViewController {
        let viewController = LoginWebViewController(loginManager: LoginManagerFactory.generate)
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: LoginWebViewController, context: Context) {}
}
