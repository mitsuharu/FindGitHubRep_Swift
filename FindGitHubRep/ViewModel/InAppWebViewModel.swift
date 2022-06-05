//
//  InAppWebViewModel.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2022/01/17.
//

import Foundation
import ReSwift

final class InAppWebViewModel: ObservableObject, StoreSubscriber {

    typealias StoreSubscriberStateType = InAppWebItem?
    @Published var item: InAppWebItem?

    init() {
        appStore.subscribe(self) {
            $0.select { selectInAppWebItem(store: $0) }
        }
    }

    deinit {
        appStore.unsubscribe(self)
    }

    func newState(state: InAppWebItem?) {
        self.item = state
    }

    public func show(url: String) {
        appStore.dispatch(InAppWebActions.show(url: url))
    }

    public func dissmiss() {
        appStore.dispatch(InAppWebActions.clear)
    }
}
