//
//  LoginManagerFactory.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-03-06.
//

import Foundation

enum LoginManagerFactory {
    /// Generates the appropriate LoginURLGenerator at runtime
    static var generate: LoginManager {
        // Todo: make this return the mock generators at runtimegit
        let config = URLSessionConfiguration.default
        return ProductionLoginManager(session: URLSession(configuration: config))
    }
}
