//
//  SafariViewModel.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2022/01/17.
//

import Foundation
import ReMVVMSwiftUI
import SwiftUI

final class InAppSafariViewModel: ObservableObject, Initializable {

    // BetterSafariView が書き込むので private(set) は不要
    // ただし、BetterSafariView#onDismiss で InAppSafariViewModel#dissmiss を呼ぶ必要あり
    @Published var item: InAppSafariViewItem? = nil
    
    @ReMVVM.State<RootState> private var state
    @ReMVVM.Dispatcher private var dispatcher
        
    required init() {
        $state.map(selectInAppSafariViewItem).assign(to: &$item)
    }
  
    public func show(url :String)  {
        dispatcher[InAppSafariViewAction.show(url: url)]()
    }
  
    func dissmiss(){
        dispatcher[InAppSafariViewAction.dismiss]()
    }
}
