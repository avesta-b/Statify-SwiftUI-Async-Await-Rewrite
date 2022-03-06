//
//  statisfyApp.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-03-06.
//

import SwiftUI
import StatifyColors

@main
struct StatifyApp: App {
    
    @AppStorage(OnboardingStatus.userDefaultsKey) var status: String?
    
    var body: some Scene {
        WindowGroup {
            RootViewFactory.rootView
                .background(Color(SColors.backgroundColor))
        }
    }
}
