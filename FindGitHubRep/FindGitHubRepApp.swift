//
//  FindGitHubRepApp.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/24.
//

import SwiftUI

@main
struct FindGitHubRepApp: App {
  
  let store = initializeRedux()
  
    var body: some Scene {
        WindowGroup {
            SearchListView().source(with: store)
//          CounterView().source(with: store)
        }
    }
}
