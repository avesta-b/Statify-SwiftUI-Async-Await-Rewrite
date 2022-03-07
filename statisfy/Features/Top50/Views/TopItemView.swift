//
//  TopItemView.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-03-06.
//

import SwiftUI
import StatifyColors

struct TopItemView: View {
    
    let viewModel: TopItemViewModel
    
    var body: some View {
        VStack {
            Text("# \(viewModel.rank)")
                .padding(12.0)
                .frame(maxWidth: .infinity, alignment: .leading)
                
            Spacer()
            Text(viewModel.text)
                .padding(12.0)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(BackgroundImageView(imageURL: viewModel.imageURL))
    }
}

struct TopItemView_Previews: PreviewProvider {
    static var previews: some View {
        TopItemView(viewModel: TopItemViewModel(text: "Hello There",
                                                rank: 1))
    }
}
