//
//  SearchListViewModel.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/12/06.
//

import Foundation
import ReMVVMSwiftUI
import SwiftUI

final class SearchRepositoryViewModel: ObservableObject, Initializable, Sendable {
    @Published private(set) var isRequesting = false
    @Published private(set) var keyword: String = ""
    @Published private(set) var page: Int = 0
    @Published private(set) var total: Int = 0
    @Published private(set) var hasNext = false
    @Published private(set) var items: [Repository] = []
    @Published private(set) var error: Error?

    @ReMVVM.State<RootState> private var state
    @ReMVVM.Dispatcher private var dispatcher

    let api = API()

    required init() {
        $state.map(selectRepositoryIsRequesting).assign(to: &$isRequesting)
        $state.map(selectRepositoryKeyword).assign(to: &$keyword)
        $state.map(selectRepositoryPage).assign(to: &$page)
        $state.map(selectRepositoryTotal).assign(to: &$total)
        $state.map(selectRepositoryHasNext).assign(to: &$hasNext)
        $state.map(selectRepositoryItems).assign(to: &$items)
        $state.map(selectRepositoryError).assign(to: &$error)
    }

    public func requestRepositories(keyword: String) {
        logger.info("SearchListViewModel#requestRepositories keyword: \(keyword)")
        Task { [weak self] in
            guard let self = self else {
                return
            }
            if self.isRequesting {
                return
            }
            await self.fetch(keyword: keyword, page: 1)
        }
    }

    public func loadMoreRepositories() {
        logger.info("SearchListViewModel#loadMoreRepositories")
        Task { [weak self] in
            guard let self = self else {
                return
            }
            if self.isRequesting || !self.hasNext {
                return
            }
            await self.fetch(keyword: self.keyword, page: self.page + 1)
        }
    }

    public func fetch(keyword: String, page: Int) async {
        do {
            await MainActor.run { [weak self] in
                // この非同期関数のなかで、画面更新に関わるところなので MainActor でメインスレッドで実行する
                self?.dispatcher[RepositoryAction.fetch(keyword: keyword, page: page)]()
            }

            // 未認証なので、リクエスト発火を抑える
            await api.delay(sec: 0.5)
            let result = try await api.searchRepositories(keyword: keyword, page: page)

            await MainActor.run { [weak self] in
                // この非同期関数のなかで、画面更新に関わるところなので MainActor でメインスレッドで実行する
                self?.dispatcher[RepositoryAction.succeeded(result)]()
            }
        } catch {
            logger.warning("error: \(error), localizedDescription: \(error.localizedDescription)")
            await MainActor.run { [weak self] in
                // この非同期関数のなかで、画面更新に関わるところなので MainActor でメインスレッドで実行する
                self?.dispatcher[RepositoryAction.failed(error)]()
            }
        }
    }

    public func openInAppSafariView(url: String) {
        dispatcher[InAppSafariViewAction.show(url: url)]()
    }

    public func enqueueToast(message: String, type: ToastType?) {
        dispatcher[ToastAction.enqueueToast(message: message, type: type)]()
    }

    public func navigate(destination: AnyView?) {
        dispatcher[RouterAction.navigate(destination: destination)]()
    }
}
