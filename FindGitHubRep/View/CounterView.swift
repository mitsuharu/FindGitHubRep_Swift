//
//  CounterView.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/26.
//

import SwiftUI
import ReMVVMSwiftUI

struct CounterView: View {

    @ReMVVM.ViewModel private var viewModel: CounterViewModel!

    var body: some View {

        VStack {
            Text("Hello, world! 22222")

            Text("Counter: \(viewModel.count)")
                .padding(.bottom)

            Button(action: viewModel.increase) {
                Text("Increase")
            }
            Button(action: viewModel.decrease) {
                Text("Decrease")
            }
        }
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView()
    }
}
