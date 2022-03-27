//
//  RootView.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2022/03/26.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        NavigationView {
            SearchRepositoryListView()
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
