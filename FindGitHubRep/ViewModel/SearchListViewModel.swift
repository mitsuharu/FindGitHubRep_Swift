//
//  SearchListViewModel.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/12/06.
//

import Foundation
import ReMVVMSwiftUI

final class SearchListViewModel: ObservableObject, Initializable {
    @Published private(set) var keyword: String = ""
    @Published private(set) var page: Int = 0
    @Published private(set) var total: Int = 0
    @Published private(set) var items: Array<Repository> = []
    @ReMVVM.State<RootState> private var state
    @ReMVVM.Dispatcher private var dispatcher
    
    var api: API = API()
  
    required init() {
        $state.map(selectRepositoryKeyword).assign(to: &$keyword)
        $state.map(selectRepositoryPage).assign(to: &$page)
        $state.map(selectRepositoryTotal).assign(to: &$total)
        $state.map(selectRepositoryItems).assign(to: &$items)
    }
      
    public func requestRepositories(keyword: String){
        Task {
            do{
//                dispatcher.dispatch(action: RepositoryAction.fetch(keyword: keyword, page: 1))
                DispatchQueue.main.async {
                    self.dispatcher[RepositoryAction.fetch(keyword: keyword, page: 1)]()
                }
                let result: SearchRepositoryResult = try await fetch(keyword: keyword, page: self.page)
                
                DispatchQueue.main.async {
                    self.dispatcher[RepositoryAction.fetchSucceeded(result)]()
                }
                debugPrint("total: \(result.total), \(result.items[0].name)")
            }catch{
                debugPrint("SearchListViewModel#requestRepositories error:\(error), localizedDescription:\(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.dispatcher[RepositoryAction.fetchFailed(error)]()
                }
            }
        }
    }
    
    public func loadMoreRepositories(){
        Task {
            do{
                if items.count >= total {
                    return
                }
                
                DispatchQueue.main.async {
                    self.dispatcher[RepositoryAction.fetch(keyword: self.keyword, page: self.page + 1)]()
                }
                let result: SearchRepositoryResult = try await fetch(keyword: self.keyword, page: self.page)
                
                DispatchQueue.main.async {
                    self.dispatcher[RepositoryAction.fetchSucceeded(result)]()
                }
            }catch{
                debugPrint("SearchListViewModel#requestRepositories error:\(error), localizedDescription:\(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.dispatcher[RepositoryAction.fetchFailed(error)]()
                }
            }
        }
    }
    
    
    func fetch(keyword: String, page: Int = 1)  async throws -> SearchRepositoryResult{
        let result: SearchRepositoryResult = try await api.searchRepositories(keyword: keyword, page: page)
        debugPrint("searchRepositories: total: \(result.total)")
        return result
    }
  
}
