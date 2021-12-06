//
//  actions.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/25.
//

import Foundation
import ReMVVMSwiftUI

enum RepositoryAction: StoreAction {
    case fetch(keyword: String, page: Int)
    case fetchSucceeded(SearchRepositoryResult)
    case fetchFailed(Error)
    
    case clear
}
