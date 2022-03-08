//
//  BackgroundImageView.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-03-07.
//

import SwiftUI
import StatifyColors

struct BackgroundImageView: View {
    
    let imageURL: String?
    
    var body: some View {
        if let unwrappedUrl = imageURL,
           let urlObj = URL(string: unwrappedUrl) {
            AsyncImageView(url: urlObj) {
                Color(UIColor.systemGray)
            }
        } else {
            Text("Loading")
        }

    }
}

struct BackgroundImageView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundImageView(imageURL: "https://i.scdn.co/image/ab6761610000e5ebfbc3faec4a370d8393bee7f1")
    }
}
