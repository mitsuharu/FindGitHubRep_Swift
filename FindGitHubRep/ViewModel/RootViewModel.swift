//
//  RootViewModel.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2022/03/26.
//

import Foundation
import ReMVVMSwiftUI
import SwiftUI

final class RootViewModel: ObservableObject, Initializable {

    @Published private(set) var destination: AnyView?
    @Published var isActive: Bool! {
        didSet {
            dispatcher[RouterAction.assignIsActive(isActive: self.isActive)]()
        }
    }
    @ReMVVM.State<RootState> private var state
    @ReMVVM.Dispatcher private var dispatcher

    required init() {
        $state.map(selectRouterDestination).assign(to: &$destination)
        $state.map(selectRouterIsActive).assign(to: &$isActive)
    }
}
