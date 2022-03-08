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
    
}
