//
//  selectors.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/26.
//

import Foundation

func selectInAppSafariViewItem(store: RootState) -> InAppSafariViewItem? {
    return store.inAppSafariView.item ?? nil
}

func selectInAppSafariViewUrl(store: RootState) -> String? {
    return store.inAppSafariView.item?.url ?? nil
}
