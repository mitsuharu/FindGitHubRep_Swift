//
//  reducers.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/25.
//

import Foundation
import ReMVVMSwiftUI
import CryptoKit

enum SafariViewReducer: Reducer {
    static func reduce(state: SafariViewState, with action: SafariViewAction) -> SafariViewState {
      switch action {
      case .show(url: let url):
          let unixtime: Int = Int(Date().timeIntervalSince1970)
          let resource = SafariViewResource(id: unixtime, url: url)
          return SafariViewState(resource: resource)
      case .dismiss:
          return SafariViewState(resource: nil)
      }
    }
}
