//
//  RootViewFactory.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-03-04.
//

import SwiftUI
import StatifyColors


enum OnboardingStatus: String {
    case needsToLogin   = "needs_to_login"
    case loggedIn       = "logged_in"
    case demoingApp     = "demoing_app"
    
    static let userDefaultsKey = "onboarding_status"
}



/// Generates the appropriate RootViewManager at runtime
enum RootViewFactory {
    
    static var rootView: some View {
        // Input logic to retrieve the appropriate rootViewManager at runtime
        return RootView()
    }
}


struct RootView: View {
    
    @AppStorage(OnboardingStatus.userDefaultsKey) var status: String?
    
    var body: some View {
        let onboarding = OnboardingStatus(rawValue: status ?? "")
        switch onboarding {
        case .needsToLogin, .none:
            WelcomeScreen()
        case .loggedIn, .demoingApp:
            Text("Hello")
//                .onAppear(perform: purgeUserDefaults)
        }
    }
}



