//
//  RouterSelectors.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2022/03/26.
//

import Foundation
import SwiftUI

func selectRouterItem(store: RootState) -> RouterItem {
    store.router.item
}

func selectRouterDestination(store: RootState) -> AnyView? {
    store.router.item.destination
}

func selectRouterIsActive(store: RootState) -> Bool {
    store.router.item.isActive
}
