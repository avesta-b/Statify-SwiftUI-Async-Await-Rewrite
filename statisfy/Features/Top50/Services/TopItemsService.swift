//
//  TopItemsService.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-03-07.
//

import Foundation

class TopItemsService: ObservableObject {
    
    enum ViewState {
        case loading
        case loaded
        case error
    }
    
    @Published var topItems: [TopItemViewModel] = []
    
    @Published private(set) var state: ViewState = .loading
    
    let topItemType: TopItemType
    
    init(topItemType: TopItemType) {
        self.topItemType = topItemType
    }
    
    
    // TO DO: leverage URLExtensions to make the appropriate HTTP requests, put each case into it's own HTTP request too
    func fetch() {
        let request = URL
    }
}
