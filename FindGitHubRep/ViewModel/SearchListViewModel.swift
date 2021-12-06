//
//  SearchListViewModel.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/12/06.
//

import Foundation
import ReMVVMSwiftUI

final class SearchListViewModel: ObservableObject, Initializable {
    @Published private(set) var isRequesting: Bool = false
    @Published private(set) var keyword: String = ""
    @Published private(set) var page: Int = 0
    @Published private(set) var total: Int = 0
    @Published private(set) var hasNext: Bool = false
    @Published private(set) var items: Array<Repository> = []
    @Published private(set) var error: Error? = nil
    
    @ReMVVM.State<RootState> private var state
    @ReMVVM.Dispatcher private var dispatcher
    
    let api: API = API()
  
    required init() {
        $state.map(selectRepositoryIsRequesting).assign(to: &$isRequesting)
        $state.map(selectRepositoryKeyword).assign(to: &$keyword)
        $state.map(selectRepositoryPage).assign(to: &$page)
        $state.map(selectRepositoryTotal).assign(to: &$total)
        $state.map(selectRepositoryHasNext).assign(to: &$hasNext)
        $state.map(selectRepositoryItems).assign(to: &$items)
        $state.map(selectRepositoryError).assign(to: &$error)
    }
          
    public func requestRepositories(keyword: String){
        logger.info("SearchListViewModel#requestRepositories keyword: \(keyword)")
        Task {
            if self.isRequesting {
                return
            }
            await fetch(keyword: keyword, page: 1)
        }
    }
    
    public func loadMoreRepositories(){
        logger.info("SearchListViewModel#loadMoreRepositories")
        Task {
            if self.isRequesting || !self.hasNext {
                return
            }
            await fetch(keyword: self.keyword, page: self.page + 1)
        }
    }
    
    public func fetch(keyword: String, page: Int) async {
        do{
            DispatchQueue.main.async {
                self.dispatcher[RepositoryAction.fetch(keyword: keyword, page: page)]()
            }
            // 未認証なので、リクエスト発火を抑える
            await api.delay(sec: 0.5)
            let result = try await api.searchRepositories(keyword: keyword, page: page)
            
            DispatchQueue.main.async {
                self.dispatcher[RepositoryAction.succeeded(result)]()
            }
        }catch{
            logger.warning("error: \(error), localizedDescription: \(error.localizedDescription)")
            DispatchQueue.main.async {
                self.dispatcher[RepositoryAction.failed(error)]()
            }
        }
    }  
}
