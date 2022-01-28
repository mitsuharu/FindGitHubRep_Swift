//
//  SafariViewModel.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2022/01/17.
//

import Foundation
import ReMVVMSwiftUI
import SwiftUI

final class SafariViewModel: ObservableObject, Initializable {
    @Published private(set) var resource: SafariViewResource? = nil
    @ReMVVM.State<RootState> private var state
    @ReMVVM.Dispatcher private var dispatcher
        
    required init() {
        $state.map(selectSafariViewResource).assign(to: &$resource)
    }
  
    public func show(url :String)  {
        dispatcher[SafariViewAction.show(url: url)]()
    }
  
    func dissmiss(){
        dispatcher[SafariViewAction.dismiss]()
    }
    
}
