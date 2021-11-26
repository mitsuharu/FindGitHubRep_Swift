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
  
  static func initialState() -> RootState{
    return RootState(counter: CounterState.initialState())
  }
}
