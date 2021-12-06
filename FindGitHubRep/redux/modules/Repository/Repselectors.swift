//
//  selectors.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/26.
//

import Foundation

func selectRepositoryKeyword(store: RootState) -> String {
    return store.repository.keyword
}

func selectRepositoryPage(store: RootState) -> Int {
    return store.repository.page
}

func selectRepositoryTotal(store: RootState) -> Int {
    return store.repository.total
}

func selectRepositoryItems(store: RootState) -> Array<Repository> {
    return store.repository.items
}

func selectRepositoryError(store: RootState) -> Error? {
    return store.repository.error
}

