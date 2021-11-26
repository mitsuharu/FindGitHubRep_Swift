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
          CounterView().source(with: store)
        }
    }
}
