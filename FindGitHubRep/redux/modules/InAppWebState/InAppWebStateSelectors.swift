//
//  InAppWebSelectors.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/26.
//

import Foundation

func selectInAppWebItem(store: AppState) -> InAppWebItem? {
    store.inAppWeb.item
}

func selectInAppWebUrl(store: AppState) -> String? {
    store.inAppWeb.item?.url
}
