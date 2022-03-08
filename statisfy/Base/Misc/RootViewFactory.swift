//
//  RootViewFactory.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-03-04.
//

import SwiftUI
import StatifyColors


/// Generates the appropriate RootViewManager at runtime
enum RootViewFactory {
    
    static var rootView: some View {
        // Input logic to retrieve the appropriate rootViewManager at runtime
        return RootView()
    }
}


struct RootView: View {
    
    @AppStorage(UserDefaultsConstants.Keys.onboardingStatus) var status: String?
    
    var body: some View {
        let onboarding = UserDefaultsConstants.OnboardingStatusValues(rawValue: status ?? "")
        switch onboarding {
        case .needsToLogin, .none:
            WelcomeScreen()
        case .loggedIn, .demoingApp:
            MainTabBarScreen()
                .onAppear {
                    purgeUserDefaults()
                }
        }
    }
    
    private func purgeUserDefaults() {
        guard UserDefaultsConstants.Values.shouldUpdateAccessToken == true else { return }
        guard let domain = Bundle.main.bundleIdentifier else { return }
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
}

// MARK: - For now, we shall purge all defaults if expiryDate passed



