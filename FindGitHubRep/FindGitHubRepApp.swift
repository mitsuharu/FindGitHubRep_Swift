//
//  FindGitHubRepApp.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/24.
//

import SwiftUI
import Logging
import ReMVVMSwiftUI
import BetterSafariView

public let logger = Logger(label: "com.example.find.github.rep")

@main
struct FindGitHubRepApp: App {
  
    let store = initializeRedux()
    
    @ReMVVM.ViewModel private var safariViewModel: SafariViewModel!

    
    var body: some Scene {
        WindowGroup {
            SearchRepositoryListView()
                .source(with: store)
                .safariView(item: safariViewModel.$resource, onDismiss: {
                    safariViewModel.dissmiss()
                }) { rep in
                    SafariView(
                        url: URL(string: rep.url)!,
                        configuration: SafariView.Configuration(
                            entersReaderIfAvailable: false,
                            barCollapsingEnabled: true
                        )
                    )
                    .preferredBarAccentColor(.clear)
                    .preferredControlAccentColor(.accentColor)
                    .dismissButtonStyle(.close)
                }
        }
    }
}
