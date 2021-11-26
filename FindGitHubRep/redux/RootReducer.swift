//
//  RootReducer.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/25.
//

import Foundation
import ReMVVMSwiftUI

struct RootReducer: Reducer {
    static func reduce(state: RootState, with action: StoreAction) -> RootState {
      
//      var nextCounter = state.counter
//      if let act = action as? CounterAction{
//        nextCounter = CounterReducer.reduce(state: state.counter, with: act)
//      }
      
      let nextCounter = action is CounterAction ? CounterReducer.reduce(state: state.counter, with: action) : state.counter
      
      return RootState(counter: nextCounter)
    }
}
