//
//  ToastView.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2022/01/28.
//

import SwiftUI
import ToastUI

/// Toast を表示する
/// root あたりに設定する
struct Toast: View {

    @ObservedObject private var viewModel = ToastViewModel()

    var body: some View {
        ZStack {
        }.toast(item: $viewModel.item,
                dismissAfter: 2.0) {
            viewModel.dequeueToast()
        } content: { item in
            VStack {
                Spacer()
                Text(item.message)
                    .bold()
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(8.0)
                    .shadow(radius: 4)
                    .padding()
            }
        }

    }
}

struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        Toast()
    }
}
