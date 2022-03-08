//
//  TokenConstants.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-03-06.
//

import Foundation

enum UserDefaultsConstants {
    
    enum Keys {
        static let accessTokenKey   = "access_token_key"
        static let refreshTokenKey  = "refresh_token_key"
        static let expiryDateKey    = "expiryDateKey"
        static let onboardingStatus = "onboarding_status"
    }
    
    enum OnboardingStatusValues: String {
        case needsToLogin   = "needs_to_login"
        case loggedIn       = "logged_in"
        case demoingApp     = "demoing_app"
    }
    
    enum Values {
        static var bearerAccessToken: String {
            let value = UserDefaults.standard.value(forKey: Keys.accessTokenKey) as? String ?? ""
            return "Bearer " + value
        }
        
        static var accessTokenExpiryDate: Int {
            let value = UserDefaults.standard.value(forKey: Keys.expiryDateKey) as? Int ?? 0
            return value
        }
        
        static var shouldUpdateAccessToken: Bool {
            let expiryDate = Values.accessTokenExpiryDate
            let current = Date().timeIntervalSince1970
            return Int(current) > expiryDate
        }
        
        static var refreshToken: String {
            let value = UserDefaults.standard.value(forKey: Keys.refreshTokenKey) as? String ?? ""
            return value
        }
    }
    
}
