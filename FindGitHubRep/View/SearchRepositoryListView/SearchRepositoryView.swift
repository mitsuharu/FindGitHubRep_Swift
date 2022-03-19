//
//  SearchListView.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/12/06.
//

import SwiftUI
import ReMVVMSwiftUI
import BetterSafariView

struct SearchRepositoryListView: View {

    @State private var searchText: String = ""
    @ReMVVM.ViewModel private var viewModel: SearchRepositoryViewModel!

    var body: some View {
        NavigationView {
            List {
                if viewModel.items.count == 0 && viewModel.isRequesting {
                    ProgressView()
                        .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
                } else {
                    ForEach(viewModel.items) { item in
                        Button {
                            viewModel.enqueueToast(message: item.url, type: nil)
                            viewModel.openInAppSafariView(url: item.url)
                        } label: {
                            RepositoryItem(repository: item).onAppear {
                                if item.id == viewModel.items.last?.id {
                                    viewModel.loadMoreRepositories()
                                }
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("リポジトリ検索")
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always)
            ).onChange(of: searchText) { newValue in
                viewModel.requestRepositories(keyword: newValue)
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SearchRepositoryListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchRepositoryListView()
    }
}
