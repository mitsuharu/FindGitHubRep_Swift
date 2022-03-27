//
//  RootView.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2022/03/26.
//

import SwiftUI

struct RootView: View {

    @ObservedObject private var nagivationService = NavigationService()

    var body: some View {
        NavigationView {
            VStack {
                SearchRepositoryListView()
                NavigationLink(
                    destination: nagivationService.destination,
                    isActive: $nagivationService.isActive) {
                    EmptyView()
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(nagivationService)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
