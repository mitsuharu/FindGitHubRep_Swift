//
//  reducers.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/25.
//

import Foundation
import ReMVVMSwiftUI

enum InAppSafariViewReducer: Reducer {
    static func reduce(state: InAppSafariViewState,
                       with action: InAppSafariViewAction) -> InAppSafariViewState {
      switch action {
      case .show(url: let url):
          let unixtime: Int = Int(Date().timeIntervalSince1970)
          let item = InAppSafariViewItem(id: unixtime, url: url)
          return InAppSafariViewState(item: item)
      case .dismiss:
          return InAppSafariViewState(item: nil)
      }
    }
}
