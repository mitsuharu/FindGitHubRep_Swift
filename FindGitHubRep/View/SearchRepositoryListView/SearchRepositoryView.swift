//
//  SearchListView.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/12/06.
//

import SwiftUI
import ReMVVMSwiftUI

private protocol SearchRepositoryListViewComponentProps {
    var items: [Repository]! { get }
    var requestStatus: RequestStatus! { get }
    var onPress: (_ repo: Repository) -> Void { get }
    var requestRepositories: (_ keyword: String) -> Void { get }
    var loadMore: () -> Void { get }
}

private struct Component: View, SearchRepositoryListViewComponentProps {

    @State private var searchText: String = ""

    let items: [Repository]!
    let requestStatus: RequestStatus!
    let onPress: (_ repo: Repository) -> Void
    let requestRepositories: (_ keyword: String) -> Void
    let loadMore: () -> Void

    var body: some View {
        List {
            if items.count == 0 && requestStatus == .loading {
                ProgressView()
                    .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
            } else {
                ForEach(items) { item in
                    Button {
                        onPress(item)
                    } label: {
                        RepositoryItem(repository: item).onAppear {
                            if item.id == items.last?.id {
                                loadMore()
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
            requestRepositories(newValue)
        }
    }
}

struct SearchRepositoryListView: View {

    @ReMVVM.ViewModel private var viewModel: SearchRepositoryViewModel!
    @ObservedObject private var navigationService = NavigationService()

    func onPress(_ repo: Repository) {
        viewModel.enqueueToast(message: "\(repo.name) の詳細画面を開きます（ただトースト表示の動作確認のため）",
                               type: nil)
        navigationService.navigate(DetailView(repository: repo))
    }

    func loadMore() {
        viewModel.loadMoreRepositories()
    }

    func requestRepositories(_ keyword: String) {
        viewModel.requestRepositories(keyword: keyword)
    }

    var body: some View {
        NavigationServiceView(navigationService) {
            Component(items: viewModel.items,
                      requestStatus: viewModel.requestStatus,
                      onPress: onPress,
                      requestRepositories: requestRepositories,
                      loadMore: loadMore)
                .onChange(of: viewModel.requestStatus) { newValue in
                    if newValue == .faild {
                        let message = "取得に失敗しました。" + (viewModel.error?.localizedDescription ?? "")
                        viewModel.enqueueToast(message: message, type: .error)
                    }
                }
        }
    }
}

struct SearchRepositoryListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchRepositoryListView()
    }
}
