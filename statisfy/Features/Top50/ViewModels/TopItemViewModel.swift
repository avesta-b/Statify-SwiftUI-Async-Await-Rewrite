//
//  TopItemViewModel.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-03-07.
//

import Foundation

struct TopItemViewModel: Identifiable {
    
    let text: String
    let rank: Int
    let imageURL: String?
    let id = UUID()
}
