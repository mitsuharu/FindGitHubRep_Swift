//
//  FindGitHubRepApp.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/24.
//

import SwiftUI
import Logging

public let logger = Logger(label: "com.example.find.github.rep")

@main
struct FindGitHubRepApp: App {
  
    let store = initializeRedux()

    var body: some Scene {
        WindowGroup {
            SearchRepositoryListView()
            InAppSafariView()
        }
    }
}
