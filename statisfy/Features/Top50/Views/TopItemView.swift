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
            HStack {
            Text("#\(viewModel.rank)")
                .padding(16)
                .font(Font.body.bold())
                .shadow(radius: 5)
            Spacer()
            }
                
            Spacer()
            HStack {
            Text(viewModel.text)
                .padding(16)
                .font(Font.body.bold())
                .shadow(radius: 5)
            Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(BackgroundImageView(imageURL: viewModel.imageURL))
    }
}

struct TopItemView_Previews: PreviewProvider {
    static var previews: some View {
        TopItemView(viewModel: TopItemViewModel(text: "Hello There",
                                                rank: 1,
                                                imageURL: ""))
    }
}
