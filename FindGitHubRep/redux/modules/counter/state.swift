//
//  state.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/25.
//

import Foundation
import ReMVVMSwiftUI

struct CounterState: StoreState {

    let count: Int

    static func initialState() -> CounterState {
        return CounterState(count: 0)
    }
}
