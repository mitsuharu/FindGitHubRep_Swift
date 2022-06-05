//
//  ToastSelectors.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2022/01/28.
//

import Foundation

func selectToastItems(store: AppState) -> [ToastItem] {
    store.toast.items
}

func selectToastItem(store: AppState) -> ToastItem? {
    let items = selectToastItems(store: store)
    return items.first
}

func selectToastItemId(store: AppState) -> Int {
    let items = selectToastItems(store: store)
    return items.first?.id ?? -1
}
