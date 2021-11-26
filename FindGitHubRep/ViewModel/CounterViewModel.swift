//
//  CounterViewModel.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/26.
//

import Foundation
import ReMVVMSwiftUI

final class CounterViewModel: ObservableObject, Initializable {

  @Published private(set) var count: Int = 0
  
  @ReMVVM.State<RootState> private var state
  @ReMVVM.Dispatcher private var dispatcher
  
  required init() {
    $state.map(selectCount).assign(to: &$count)
  }
  
  public func increase(){
    dispatcher[CounterAction.increase]()
  }
  
  func decrease(){
    dispatcher[CounterAction.decrease]()
  }
  
}
