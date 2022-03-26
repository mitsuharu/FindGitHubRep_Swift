//
//  DetailViewModal.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2022/03/26.
//

import Foundation
import ReMVVMSwiftUI

final class DetailViewModel: ObservableObject, Initializable {

    @ReMVVM.State<RootState> private var state
    @ReMVVM.Dispatcher private var dispatcher

    @Published var markdown: String = ""
    @Published var requestStatusMarkdown: RequestStatus = .initialize

    let api = API()

    required init() {
    }

    public func openInAppSafariView(url: String) {
        dispatcher[InAppSafariViewAction.show(url: url)]()
    }

    public func requestMarkdown(repository: Repository) async {
        do {
            self.requestStatusMarkdown = .loading
            let url = try await api.requestReadmeDownloadUrl(owner: repository.owner.name, repo: repository.name)
            self.markdown = try await api.downloadReadme(url: url)
            self.requestStatusMarkdown = .success
        } catch {
            logger.warning("error: \(error), localizedDescription: \(error.localizedDescription)")
            self.markdown = ""
            self.requestStatusMarkdown = .faild
        }
    }

}
