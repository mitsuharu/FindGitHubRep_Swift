//
//  DetailViewModal.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2022/03/26.
//

import Foundation
import ReMVVMSwiftUI

final class DetailViewModel: ObservableObject, Initializable, Sendable {

    @ReMVVM.State<RootState> private var state
    @ReMVVM.Dispatcher private var dispatcher

    @Published var textMarkdown: String = ""
    @Published var requestStatusMarkdown: RequestStatus = .initialize

    let api = API()

    required init() {
    }

    public func openInAppSafariView(url: String) {
        dispatcher[InAppSafariViewAction.show(url: url)]()
    }

    public func requestMarkdown(repository: Repository) {
        Task { [weak self] in
            guard let self = self else {
                return
            }
            do {
                self.requestStatusMarkdown = .loading
                let url = try await api.requestReadmeDownloadUrl(owner: repository.owner.name,
                                                                 repo: repository.name)
                self.textMarkdown = try await api.downloadReadme(url: url)
                self.requestStatusMarkdown = .success
            } catch {
                logger.warning("error: \(error), localizedDescription: \(error.localizedDescription)")
                self.textMarkdown = ""
                self.requestStatusMarkdown = .faild
            }
        }
    }

}
