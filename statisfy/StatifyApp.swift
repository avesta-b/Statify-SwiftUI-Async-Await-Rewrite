//
//  statisfyApp.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-03-06.
//

import SwiftUI

@main
struct StatifyApp: App {
    
    var body: some Scene {
        WindowGroup {
            RootViewManagerFactory.rootViewManager.rootView
        }
    }
}
