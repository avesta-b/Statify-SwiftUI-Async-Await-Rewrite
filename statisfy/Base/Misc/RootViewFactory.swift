//
//  RootViewFactory.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-03-04.
//

import SwiftUI
import StatifyColors


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
    
    @ViewBuilder
    var rootView: some View {
        
        switch self.status {
        case .needsToLogin:
            WelcomeScreen()
        case .loggedIn:
            Text("Hello")
        }
    }
    
    private var status: OnboardingStatus {
        guard let onboardingStatusValue = UserDefaults.standard.string(forKey: OnboardingStatus.userDefaultsKey),
              let onboardingStatus = OnboardingStatus(rawValue: onboardingStatusValue) else {
              return .needsToLogin
              }
        return onboardingStatus
    }
}


/// Generates the appropriate RootViewManager at runtime
enum RootViewManagerFactory {
    
    static var rootViewManager: some RootViewManagerProtocol {
        // Input logic to retrieve the appropriate rootViewManager at runtime
        return RootViewManager()
    }
}




