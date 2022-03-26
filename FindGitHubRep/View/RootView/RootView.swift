//
//  RootView.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2022/03/26.
//

import SwiftUI
import ReMVVMSwiftUI

struct RootView: View {

    @ReMVVM.ViewModel private var viewModel: RootViewModel!

    var body: some View {
        NavigationView {
            VStack {
                SearchRepositoryListView()
                InAppSafariView()
                Toast()
                NavigationLink(
                    destination: viewModel.destination,
                    isActive: $viewModel.isActive) {
                    EmptyView()
                }
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
