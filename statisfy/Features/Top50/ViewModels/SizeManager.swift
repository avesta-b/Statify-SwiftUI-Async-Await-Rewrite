//
//  SizeManager.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-03-07.
//

import SwiftUI

// NO NEED TO OVERENGINEER

// JUST MAKE A FUNCTION THAT RETRIEVES THE MODEL and then updates ViewModel

class SizeManager: ObservableObject {
    
    @Published private(set) var columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    func width(geometry: GeometryProxy) -> CGFloat {
        if columns.count == 2 {
            return (geometry.size.width - 32) / 2
        }
        
        return geometry.size.width / 3
    }
    
    func toggleColumns() {
        if self.columns.count == 1 {
            self.columns = [GridItem(.flexible()), GridItem(.flexible())]
        } else {
            self.columns = [GridItem(.flexible())]
        }
    }
    
}
