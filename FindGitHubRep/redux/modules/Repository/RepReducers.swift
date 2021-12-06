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
                    total:  page == 1 ? 0 : state.total,
                    items: page == 1 ? [] : state.items,
                    error: nil)
                
            case .fetchSucceeded(let value):
                let nextItems = state.items + value.items
                return state.copyWith(isRequesting:false, total: value.total, items: nextItems, error: nil)
                
            case .fetchFailed(let value):
                return state.copyWith(isRequesting:false, error: value)
                        
            case .clear:
                return RepositoryState.initialState()
      }
    }
}
