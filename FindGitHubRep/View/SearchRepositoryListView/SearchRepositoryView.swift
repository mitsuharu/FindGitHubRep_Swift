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
    @State private var presentingRepositoryInSafariView: Repository? = nil
    @ReMVVM.ViewModel private var viewModel: SearchRepositoryViewModel!
    
    var body: some View {
        NavigationView{
            List{
                if viewModel.items.count == 0 && viewModel.isRequesting {
                    ProgressView()
                        .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
                } else{
                    ForEach(viewModel.items){ item in
                        Button {
                            self.presentingRepositoryInSafariView = item
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
            }.safariView(item: $presentingRepositoryInSafariView) { rep in
                SafariView(
                    url: URL(string: rep.url)!,
                    configuration: SafariView.Configuration(
                        entersReaderIfAvailable: false,
                        barCollapsingEnabled: true
                    )
                )
                    .preferredBarAccentColor(.clear)
                    .preferredControlAccentColor(.accentColor)
                    .dismissButtonStyle(.close)
            }
        }
    }
}

struct SearchRepositoryListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchRepositoryListView()
    }
}
