//
//  TopItemsService.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-03-07.
//

import Foundation

class TopItemsService: ObservableObject {
    
    @Published var topItems: [TopItemViewModel] = []
    
}
