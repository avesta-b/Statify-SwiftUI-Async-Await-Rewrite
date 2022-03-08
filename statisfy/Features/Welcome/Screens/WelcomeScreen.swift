//
//  WelcomeScreen.swift
//  statisfy
//
//  Created by Avesta Barzegar on 2022-03-06.
//

import SwiftUI
import StatifyColors

struct WelcomeScreen: View {
    
    @State private var showingSheet = false
    
    var body: some View {
        VStack {
            Spacer()
            GreetingTextView()
            Spacer()
            GetStartedButton(action: { showingSheet.toggle() })
                .sheet(isPresented: $showingSheet) {
                    LoginWebScreen()
                }
                .padding(8.0)
            DemoTheAppButton {
                debugPrint("Demo started")
            }
            .padding(EdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 16))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(SColors.backgroundColor)
                        .ignoresSafeArea())
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
    }
}
