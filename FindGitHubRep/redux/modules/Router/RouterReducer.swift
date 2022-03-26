//
//  RouterReducer.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2022/03/26.
//

import Foundation
import ReMVVMSwiftUI

enum RouterReducer: Reducer {
    static func reduce(state: RouterState,
                       with action: RouterAction) -> RouterState {
        switch action {
        case .navigate(destination: let destination):
            let item = RouterItem(destination: destination, isActive: destination != nil)
            return RouterState(item: item)

        case .assignIsActive(isActive: let isActive):
            let item = RouterItem(destination: isActive ? state.item.destination : nil,
                                  isActive: isActive)
            return RouterState(item: item)
        }
    }
}
