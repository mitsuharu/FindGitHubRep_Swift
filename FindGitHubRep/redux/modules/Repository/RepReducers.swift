//
//  reducers.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/25.
//

import Foundation
import ReMVVMSwiftUI

enum RepositoryReducer: Reducer {
    static func reduce(state: RepositoryState, with action: RepositoryAction) -> RepositoryState {
        switch action {
        case .fetch(keyword: let keyword, page: let page):
            return state.copyWith(
                isRequesting: true,
                keyword: keyword,
                page: page,
                total: page == 1 ? 0 : state.total,
                hasNext: page == 1 ? true : state.hasNext,
                items: page == 1 ? [] : state.items,
                error: nil)

        case .succeeded(let value):
            let nextItems = state.items + value.items
            let nextHasNext = state.items.count == 0 || state.items.count >= state.total
            return state.copyWith(
                isRequesting: false,
                total: value.total,
                hasNext: nextHasNext,
                items: nextItems, error: nil)

        case .failed(let value):
            return state.copyWith(isRequesting: false, hasNext: false, error: value)

        case .clear:
            return RepositoryState.initialState()
        }
    }
}
