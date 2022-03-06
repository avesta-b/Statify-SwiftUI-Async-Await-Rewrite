//
//  LoginManager.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-03-06.
//

import Foundation

/// Protocol that generates LoginURL, can be swapped out at runtime for unit tests and mocks
/// Use LoginURLGenerator.generate to retrieve the appropriate loginURLGenerator
protocol LoginManager {
    var loginRequest: URLRequest { get }
    
    func extractCode(url: URL) -> String
}

struct LoginManagerFactory {
    /// Generates the appropriate LoginURLGenerator at runtime
    static public var generate: LoginManager {
        // Todo: make this return the mock generators at runtimegit
        return ProductionLoginManager()
    }
}

struct ProductionLoginManager: LoginManager {
    
    
    var loginRequest: URLRequest {
        // Force unwrap URL
        let url = URL.generate(url: "https://accounts.spotify.com/authorize",
                               with: [
                                "client_id"     : LoginSensitiveInfo.clientId,
                                "redirect_uri"  : LoginSensitiveInfo.redirectURI,
                                "response_type" : "code",
                                "show_dialog"   : "true",
                                "scope"         : "user-top-read,user-read-recently-played,user-read-private,user-read-email"
                               ])!
        let request = URLRequest(url: url)
        return request
    }
    
    func extractCode(url: URL) -> String {
        guard let queryItems = URLComponents(string: url.absoluteString)?
                .queryItems else {
                    return ""
                }
        
        // Make sure access was granted
        guard queryItems
                .contains(where: {$0.value != "access_denied"}) != false else {
                    // Handle access being denied here
                    return ""
                }
        
        guard let item = queryItems
                .first(where: { $0.name == "code"} ),
              let code = item.value else {
                    // Handle no code here
                    return ""
                }
        
        return code
    }
    
}
