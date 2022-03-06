//
//  Strings.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-03-06.
//

import Foundation

enum Strings {
    
    // MARK: - Get started strings
    static var welcome: String {
        return NSLocalizedString("Welcome", comment: "Welcomes users on the get started screen")
    }
    
    static var tapTheGetStartedButton: String {
        return NSLocalizedString("Tap the get started button to link your Spotify account and view your stats",
                                 comment: "Tells user to get started on the get started screen")
    }
    
    static var getStarted: String {
        return NSLocalizedString("Get Started", comment: "Text on the get started button on the get started screen")
    }
    
    static var demoTheApp: String {
        return NSLocalizedString("Demo the app", comment: "Text on button that allows users to demo the app")
    }
    
}
