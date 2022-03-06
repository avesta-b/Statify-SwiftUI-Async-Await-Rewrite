//
//  SpotifyGreenButton.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-03-06.
//

import SwiftUI
import StatifyColors

struct GetStartedButton: View {
    
    let action: () -> Void
    
    var body: some View {
        Button(Strings.getStarted, action: action)
            .padding(16)
            .frame(minWidth: 250)
            .background(Color(SColors.spotifyGreen))
            .clipShape(Capsule())
            .foregroundColor(Color(SColors.spotifyWhite))
            .font(Font.headline.bold())
            
    }
}

struct SpotifyGreenButton_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedButton(action: {
            print("Nothing")
        })
    }
}
