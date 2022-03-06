//
//  RootViewFactory.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-03-04.
//

import SwiftUI


enum OnboardingStatus: String {
    case needsToLogin = "needs_to_login"
    case loggedIn = "logged_in"
    
    static let userDefaultsKey = "onboarding_status"
}

protocol RootViewManagerProtocol {
    associatedtype T: View
    var rootView: T { get }
}


struct RootViewManager: RootViewManagerProtocol {
    
    var rootView: some View {
        
        // If there is no value, return the fallback view
        guard let onboardingStatusValue = UserDefaults.standard.value(forKey: OnboardingStatus.userDefaultsKey),
              let onboardingStatusValue = onboardingStatusValue as? String,
              let onboardingStatus = OnboardingStatus(rawValue: onboardingStatusValue) else {
            return WelcomeScreen()
        }
        
        switch onboardingStatus {
        case .needsToLogin:
            // Show OnboardingView
            return WelcomeScreen()
        case .loggedIn:
            // Show View with status
            return WelcomeScreen()
        }
    }
}


/// Generates the appropriate RootViewManager at runtime
enum RootViewManagerFactory {
    
    static var rootViewManager: some RootViewManagerProtocol {
        // Input logic to retrieve the appropriate rootViewManager at runtime
        return RootViewManager()
    }
}




