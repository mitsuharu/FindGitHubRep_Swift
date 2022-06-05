//
//  SearchRepositoryViewModel2.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2022/03/28.
//

import Foundation
import ReSwift

final class SearchRepositoryViewModel: ObservableObject, Sendable {

    @Published private(set) var requestStatus: RequestStatus = .initialize
    @Published private(set) var keyword: String = ""
    @Published private(set) var page: Int = 0
    @Published private(set) var total: Int = 0
    @Published private(set) var hasNext = false
    @Published private(set) var items: [Repository] = []
    @Published private(set) var error: Error?

    let api = API()

    required init() {
    }

    public func requestRepositories(keyword: String) {
        logger.info("SearchListViewModel#requestRepositories keyword: \(keyword)")
        Task { [weak self] in
            guard let self = self else {
                return
            }
            if self.requestStatus == .loading {
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
            if self.requestStatus == .loading || !self.hasNext {
                return
            }
            await self.fetch(keyword: self.keyword, page: self.page + 1)
        }
    }

    public func fetch(keyword: String, page: Int) async {
        do {
            await MainActor.run {
                self.requestStatus = .loading
            }
            // 未認証なので、リクエスト発火を抑える
            await api.delay(sec: 0.5)
            let result = try await api.searchRepositories(keyword: keyword, page: page)

            await MainActor.run {
                self.keyword = keyword
                self.page = page
                self.items += result.items
                self.total = result.total
                self.hasNext = self.items.count < self.total
                self.requestStatus = .success
            }
        } catch {
            logger.warning("error: \(error), localizedDescription: \(error.localizedDescription)")
            await MainActor.run {
                self.requestStatus = .faild
                self.error = error
            }
        }
    }

    public func openInAppSafariView(url: String) {
        appStore.dispatch(InAppWebActions.show(url: url))
    }

    public func enqueueToast(message: String, type: ToastType?) {
        appStore.dispatch(ToastActions.enqueueToast(message: message, type: type))
    }

}
