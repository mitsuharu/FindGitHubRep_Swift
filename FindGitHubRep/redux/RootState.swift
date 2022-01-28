//
//  RootState.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/25.
//

import Foundation
import ReMVVMSwiftUI

struct RootState: StoreState {
    let counter: CounterState
    let repository: RepositoryState
    let safariView: SafariViewState
  
    static func initialState() -> RootState{
      return RootState(
          counter: CounterState.initialState(),
          repository: RepositoryState.initialState(),
          safariView: SafariViewState.initialState()
      )
    }
}
