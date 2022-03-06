//
//  GreetingTextView.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-03-06.
//

import SwiftUI
import StatifyColors

struct GreetingTextView: View {
    var body: some View {
        Group {
            Text(Strings.welcome)
                .multilineTextAlignment(.center)
                .foregroundColor(Color(SColors.spotifyWhite))
                .font(Font.title.bold())
                .padding(8.0)
            Text(Strings.tapTheGetStartedButton)
                .multilineTextAlignment(.center)
                .font(Font.headline.bold())
                .foregroundColor(Color(SColors.spotifyWhite))
                .padding(EdgeInsets(top: 8.0,
                                    leading: 16.0,
                                    bottom: 16.0,
                                    trailing: 16.0))
        }
    }
}

struct GreetingTextView_Previews: PreviewProvider {
    static var previews: some View {
        GreetingTextView()
    }
}
