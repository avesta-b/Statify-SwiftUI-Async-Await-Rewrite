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
    let imageURL: String = "https://i.scdn.co/image/ab6761610000e5ebfbc3faec4a370d8393bee7f1"
    let id = UUID()
}
