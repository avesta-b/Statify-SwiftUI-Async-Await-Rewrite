//
//  DemoTheAppButton.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-03-06.
//

import SwiftUI
import StatifyColors

struct DemoTheAppButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button(Strings.demoTheApp, action: action)
            .padding(16.0)
            .frame(minWidth: 150)
            .background(Color(SColors.spotifyGray))
            .clipShape(Capsule())
            .foregroundColor(Color(SColors.spotifyWhite))
            .font(Font.subheadline.bold())
    }
}

struct DemoTheAppButton_Previews: PreviewProvider {
    static var previews: some View {
        DemoTheAppButton(action: {
            print("nothing")
        })
    }
}
