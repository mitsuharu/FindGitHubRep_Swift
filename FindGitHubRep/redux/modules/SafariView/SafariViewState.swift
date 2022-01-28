//
//  state.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/25.
//

import Foundation
import ReMVVMSwiftUI

struct SafariViewResource: Identifiable {
    let id: Int
    let url: String
}

struct SafariViewState: StoreState {
    
  let resource: SafariViewResource?
  
  static func initialState() -> SafariViewState{
    return SafariViewState(resource: nil)
  }
}
