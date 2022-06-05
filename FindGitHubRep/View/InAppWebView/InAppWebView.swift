//
//  InAppSafariView.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2022/01/28.
//

import SwiftUI
import ReSwift
import BetterSafariView

/// InAppSafariView を表示する
/// root あたりに設定する
struct InAppWebView: View {

    @ObservedObject private var viewModel = InAppWebViewModel()

    var body: some View {
        VStack {
        }.safariView(item: $viewModel.item, onDismiss: {
            viewModel.dissmiss()
        }) { item in
            SafariView(
                url: URL(string: item.url)!,
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

struct InAppWebView_Previews: PreviewProvider {
    static var previews: some View {
        InAppWebView()
    }
}
