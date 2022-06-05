//
//  DetailViewModal.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2022/03/26.
//

import Foundation
import ReSwift

final class DetailViewModel: ObservableObject, Sendable {

    @Published var textMarkdown: String = ""
    @Published var requestStatusMarkdown: RequestStatus = .initialize

    let api = API()
    let inAppWebViewModel = InAppWebViewModel()

    required init() {
    }

    public func openInAppSafariView(url: String) {
        inAppWebViewModel.show(url: url)
    }

    public func requestMarkdown(repository: Repository) {
        Task { [weak self] in
            guard let self = self else {
                return
            }
            do {
                await MainActor.run {
                    self.requestStatusMarkdown = .loading
                }
                let url = try await api.requestReadmeDownloadUrl(owner: repository.owner.name,
                                                                 repo: repository.name)
                let result = try await api.downloadReadme(url: url)

                await MainActor.run {
                    self.textMarkdown = result
                    self.requestStatusMarkdown = .success
                }

            } catch {
                logger.warning("error: \(error), localizedDescription: \(error.localizedDescription)")
                await MainActor.run {
                    self.textMarkdown = ""
                    self.requestStatusMarkdown = .faild
                }
            }
        }
    }

}
