//
//  selectors.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/26.
//

import Foundation

func selectSafariViewResource(store: RootState) -> SafariViewResource? {
    return store.safariView.resource ?? nil
}

func selectSafariViewUrl(store: RootState) -> String? {
    return store.safariView.resource?.url ?? nil
}
