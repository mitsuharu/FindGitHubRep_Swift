//
//  state.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/25.
//

import Foundation
import ReMVVMSwiftUI

struct InAppSafariViewItem: Identifiable {
    let id: Int
    let url: String
}

struct InAppSafariViewState: StoreState {

    let item: InAppSafariViewItem?

    static func initialState() -> InAppSafariViewState {
        return InAppSafariViewState(item: nil)
    }
}
