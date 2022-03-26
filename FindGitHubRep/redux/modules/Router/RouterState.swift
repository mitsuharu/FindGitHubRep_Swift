//
//  RouterState.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2022/03/26.
//

import Foundation
import ReMVVMSwiftUI
import SwiftUI

struct RouterItem {
    let destination: AnyView?
    var isActive: Bool
}

struct RouterState: StoreState {
    let item: RouterItem

    static func initialState() -> RouterState {
        let item = RouterItem(destination: nil, isActive: false)
        return RouterState(item: item)
    }
}
