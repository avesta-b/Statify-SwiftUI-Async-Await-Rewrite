//
//  TopItemsVGridView.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-03-06.
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

struct TopItemsVGridView: View {
    
    @StateObject var service: TopItemsService
    
    @StateObject var sizeManager: SizeManager = SizeManager()
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVGrid(columns: sizeManager.columns) {
                    ForEach(service.topItems) { item in
                        TopItemView(viewModel: item)
                            .cornerRadius(8.0)
                            .frame(height: sizeManager.width(geometry: geometry))
                            .padding(8)
                            

                    }
                }
                
            }
        }
    }
}

struct TopItemsVGridView_Previews: PreviewProvider {
    static var previews: some View {
        TopItemsVGridView(service: TopItemsService(topItemType: .artists))
        TopItemsVGridView(service: TopItemsService(topItemType: .tracks))
    }
}
