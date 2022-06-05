//
//  FindGitHubRepApp.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/24.
//

import SwiftUI
import Logging

let appStore = makeAppStore()
public let logger = Logger(label: "com.example.find.github.rep")

@main
struct FindGitHubRepApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
            InAppWebView()
            Toast()
        }
    }
}
