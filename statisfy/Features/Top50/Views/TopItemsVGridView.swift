//
//  TopItemsVGridView.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-03-06.
//

import SwiftUI

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
        .task {
            await service.fetch()
        }
    }
}

struct TopItemsVGridView_Previews: PreviewProvider {
    static var previews: some View {
        TopItemsVGridView(service: TopItemsService(topItemType: .artists, timeRange: .shortTerm))
        TopItemsVGridView(service: TopItemsService(topItemType: .tracks, timeRange: .mediumTerm))
    }
}
