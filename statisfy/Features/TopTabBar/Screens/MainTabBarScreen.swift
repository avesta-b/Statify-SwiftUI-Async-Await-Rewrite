//
//  MainTabBarScreen.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-03-06.
//

import SwiftUI
import StatifyColors

// Make a generic LazyVGridView that takes a parameter of a model which will be an instance of a protocol
// This view will be responsible for top 50 tracks and artists

// Make a generic List View for recent tracks

// Make a generic view for logging out of the application



struct MainTabBarScreen: View {
    var body: some View {
        TabView {
            TopItemsVGridView(service: TopItemsService(topItemType: .tracks, timeRange: .shortTerm))
                .tabItem {
                    Label("Tracks", systemImage: "music.note.house")
                }
            TopItemsVGridView(service: TopItemsService(topItemType: .tracks, timeRange: .mediumTerm))
                .tabItem {
                    Label("Tracks", systemImage: "music.note.house")
                }
            TopItemsVGridView(service: TopItemsService(topItemType: .tracks, timeRange: .longTerm))
                .tabItem {
                    Label("Tracks", systemImage: "music.note.house")
                }
            TopItemsVGridView(service: TopItemsService(topItemType: .artists, timeRange: .shortTerm))
                .tabItem {
                    Label("Tracks", systemImage: "person.3")
                }
            TopItemsVGridView(service: TopItemsService(topItemType: .artists, timeRange: .mediumTerm))
                .tabItem {
                    Label("Tracks", systemImage: "person.3")
                }
            TopItemsVGridView(service: TopItemsService(topItemType: .artists, timeRange: .longTerm))
                .tabItem {
                    Label("Tracks", systemImage: "person.3")
                }
        }
        .onAppear {
            onTabBarAppear()
        }
    }
}



struct MainTabBarScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBarScreen()
    }
}

fileprivate func onTabBarAppear() {
    let scaleFactor = UIScreen.main.bounds.width/414
    let font = UIFont.systemFont(ofSize: 12 * scaleFactor, weight: .semibold)
    let colorSelected = SColors.spotifyGreen
    let cololorUnselected = SColors.spotifyWhite
    let attributesNormal = [
        NSAttributedString.Key.foregroundColor: cololorUnselected,
        NSAttributedString.Key.font: font
    ]
    
    let attributesSelected = [
        NSAttributedString.Key.foregroundColor: colorSelected,
        NSAttributedString.Key.font: font
    ]

    UITabBarItem.appearance().setTitleTextAttributes(attributesNormal, for: .normal)
    UITabBarItem.appearance().setTitleTextAttributes(attributesSelected, for: .selected)
    UITabBar.appearance().barTintColor = SColors.tertiaryBackgroundColor
    UITabBar.appearance().isTranslucent = false
    UITabBar.appearance().tintColor = SColors.spotifyGreen
}
