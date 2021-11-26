//
//  selectors.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/26.
//

import Foundation

func selectCount(store:RootState) -> Int {
  return store.counter.count
}
