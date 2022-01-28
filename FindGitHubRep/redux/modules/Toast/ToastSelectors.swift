//
//  ToastSelectors.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2022/01/28.
//

import Foundation

func selectToastItems(store: RootState) -> [ToastItem] {
    return store.toast.items
}

func selectToastItem(store: RootState) -> ToastItem? {
    let items = selectToastItems(store: store)
    return items.first
}

func selectToastItemId(store: RootState) -> Int {
    let items = selectToastItems(store: store)
    return items.first?.id ?? -1
}
