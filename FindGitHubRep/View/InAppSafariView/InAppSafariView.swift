//
//  InAppSafariView.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2022/01/28.
//

import SwiftUI
import ReMVVMSwiftUI
import BetterSafariView

/// InAppSafariView を表示する
/// root あたりに設定する
struct InAppSafariView: View {
    
    @ReMVVM.ViewModel private var viewModel: InAppSafariViewModel!
    
    var body: some View {
        VStack {
        }.safariView(item: $viewModel.resource, onDismiss: {
            viewModel.dissmiss()
        }) { rep in
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

struct InAppSafariView_Previews: PreviewProvider {
    static var previews: some View {
        InAppSafariView()
    }
}
