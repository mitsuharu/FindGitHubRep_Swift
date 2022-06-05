//
//  ToastViewModel.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2022/01/28.
//

import Foundation
import ReSwift

final class ToastViewModel: ObservableObject, StoreSubscriber {

    typealias StoreSubscriberStateType = ToastItem?

    @Published var item: ToastItem?
    private var itemId: Int?

    init() {
        appStore.subscribe(self) {
            $0.select { selectToastItem(store: $0) }
        }
    }

    deinit {
        appStore.unsubscribe(self)
    }

    func newState(state: ToastItem?) {
        self.item = state
        self.itemId = state?.id
    }

    public func enqueueToast(message: String, type: ToastType?) {
        appStore.dispatch(ToastActions.enqueueToast(message: message, type: type))
    }

    public func dequeueToast() {
        if let itemId = self.itemId {
            appStore.dispatch(ToastActions.dequeueToast(id: itemId))
        }
    }

    public func clear() {
        appStore.dispatch(ToastActions.clearToast)
    }
}
