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
    
    var api: API = API()
  
  required init() {
    $state.map(selectCount).assign(to: &$count)
  }
  

    public func increase()  {
    dispatcher[CounterAction.increase]()
      
        
        if #available(iOS 15.0, *) {
            Task {
                do{
                   try await searchRepositories()
                }catch{
                    debugPrint(error)
                }
            }
        } else {
            // Fallback on earlier versions
        }
        
   
  }
  
  func decrease(){
    dispatcher[CounterAction.decrease]()
  }
    
    @available(iOS 15.0.0, *)
    func searchRepositories()  async throws -> SearchRepositoryResult{
        let result: SearchRepositoryResult = try await api.searchRepositories(keyword: "swift")
        debugPrint("searchRepositories: total: \(result.total)")
        return result
    }
  
}
