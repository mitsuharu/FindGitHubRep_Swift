//
//  InitializeRedux.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/25.
//

import Foundation
import ReMVVMSwiftUI

func initializeRedux() -> Store<RootState> {
  
    let initialState: RootState = RootState.initialState()
    
    let middleware: [AnyMiddleware] = []
    
    let stateMappers: [StateMapper<RootState>] = [
      StateMapper(for: \.counter.count),
    ]

    let store: Store<RootState> = Store(with: initialState,
                                        reducer: RootReducer.self,
                                        middleware: middleware,
                                        stateMappers: stateMappers)
    ReMVVM.initialize(with: store)
    
    return store
}
