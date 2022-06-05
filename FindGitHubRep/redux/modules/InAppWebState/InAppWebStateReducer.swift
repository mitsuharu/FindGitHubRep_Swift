//
//  reducers.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/25.
//

import Foundation
import ReSwift

func InAppReducers(action: InAppWebActions, state: InAppWebState) -> InAppWebState {
    switch action {
    case .show(url: let url):
        let unixtime = Int(Date().timeIntervalSince1970)
        let item = InAppWebItem(id: unixtime, url: url)
        return InAppWebState(item: item)
    case .clear:
        return InAppWebState(item: nil)
    }
}
