//
//  state.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/25.
//

import Foundation
import ReMVVMSwiftUI

struct RepositoryState: StoreState {
    
    let isRequesting: Bool
    let keyword: String
    let page: Int
    let total: Int
    let hasNext: Bool
    let items: Array<Repository>
    let error: Error?
    
    static func initialState() -> RepositoryState{
        return RepositoryState(
            isRequesting: false,
            keyword: "",
            page: 0,
            total: 0,
            hasNext: true,
            items: [],
            error: nil
        )
    }
    
    func copyWith(
        isRequesting: Bool? = nil,
        keyword: String? = nil,
        page: Int? = nil,
        total: Int? = nil,
        hasNext: Bool? = nil,
        items: Array<Repository>? = nil,
        error: Error? = nil) -> RepositoryState
    {
        return RepositoryState(
            isRequesting: isRequesting ?? self.isRequesting,
            keyword: keyword ?? self.keyword,
            page: page ?? self.page,
            total: total ?? self.total,
            hasNext: hasNext ?? self.hasNext,
            items: items ?? self.items,
            error: error ?? self.error
        )
    }
}
