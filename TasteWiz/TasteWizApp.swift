//
//  TasteWizApp.swift
//  TasteWiz
//
//  Created by user46a on 28/12/23.
//

import SwiftUI

@main
struct TasteWizApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}

struct MainView: View {
    @State private var showStartPage = true

    var body: some View {
        Group {
            if showStartPage {
                StartPage()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            withAnimation {
                                showStartPage = false
                            }
                        }
                    }
            } else {
                StartPage2()
            }
        }
    }
}
