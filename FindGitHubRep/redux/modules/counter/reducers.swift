//
//  reducers.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/25.
//

import Foundation
import ReMVVMSwiftUI

enum CounterReducer: Reducer {
    static func reduce(state: CounterState, with action: CounterAction) -> CounterState {
        switch action {
        case .increase:
            return CounterState(count: state.count + 1)
        case .decrease:
            return  CounterState(count: state.count - 1)
        case .assign(value: let value):
            return  CounterState(count: value)
        }
    }
}
