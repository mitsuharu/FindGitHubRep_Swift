//
//  ToastViewModel.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2022/01/28.
//

import Foundation
import ReMVVMSwiftUI
import SwiftUI

final class ToastViewModel: ObservableObject, Initializable {

    // private(set) は不要。ただし、onDismiss で ToastViewModel#dissmiss を呼ぶ必要あり
    @Published var item: ToastItem? = nil
 
    @Published private(set) var itemId: Int = -1
 
    @ReMVVM.State<RootState> private var state
    @ReMVVM.Dispatcher private var dispatcher
        
    required init() {
        $state.map(selectToastItem).assign(to: &$item)
        $state.map(selectToastItemId).assign(to: &$itemId)
    }
  
    public func enqueueToast(message :String, type: ToastType?)  {
        dispatcher[ToastAction.enqueueToast(message: message, type: type)]()
    }
  
    public func dequeueToast(id: Int){
        dispatcher[ToastAction.dequeueToast(id: id)]()
    }
    
    public func clear(){
        dispatcher[ToastAction.clearToast]()
    }
}

