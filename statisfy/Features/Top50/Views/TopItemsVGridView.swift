//
//  TopItemsVGridView.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-03-06.
//

import SwiftUI

// NO NEED TO OVERENGINEER

// JUST MAKE A FUNCTION THAT RETRIEVES THE MODEL and then updates ViewModel

struct TopItemViewModel: Identifiable {
    
    let text: String
    let rank: Int
    
    let id = UUID()
}

class TopItemsModel: ObservableObject {
    
    @Published var topItems: [TopItemViewModel] = []
    
    init() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
        self.topItems = [
                TopItemViewModel(text: "A", rank: 1),
                TopItemViewModel(text: "B", rank: 2),
                TopItemViewModel(text: "C", rank: 3),
                TopItemViewModel(text: "D", rank: 4),
                TopItemViewModel(text: "E", rank: 5),
                TopItemViewModel(text: "F", rank: 6),
                TopItemViewModel(text: "A", rank: 1),
                TopItemViewModel(text: "B", rank: 2),
                TopItemViewModel(text: "C", rank: 3),
                TopItemViewModel(text: "D", rank: 4),
                TopItemViewModel(text: "E", rank: 5),
                TopItemViewModel(text: "F", rank: 6),
                TopItemViewModel(text: "A", rank: 1),
                TopItemViewModel(text: "B", rank: 2),
                TopItemViewModel(text: "C", rank: 3),
                TopItemViewModel(text: "D", rank: 4),
                TopItemViewModel(text: "E", rank: 5),
                TopItemViewModel(text: "F", rank: 6),
                TopItemViewModel(text: "A", rank: 1),
                TopItemViewModel(text: "B", rank: 2),
                TopItemViewModel(text: "C", rank: 3),
                TopItemViewModel(text: "D", rank: 4),
                TopItemViewModel(text: "E", rank: 5),
                TopItemViewModel(text: "F", rank: 6)
            ]
        
//        }
    }
}

struct TopItemsVGridView: View {
    
    @StateObject var model = TopItemsModel()
    
    let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(model.topItems) { item in
                        TopItemView(viewModel: item)
                            .cornerRadius(8.0)
                            .padding(8)
                            .frame(height: (geometry.size.width - 32) / 2)
                    
                    }
                }
                
            }
        }
    }
}

struct TopItemsVGridView_Previews: PreviewProvider {
    static var previews: some View {
        TopItemsVGridView()
    }
}
