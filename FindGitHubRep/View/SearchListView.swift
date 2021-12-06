//
//  SearchListView.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/12/06.
//

import SwiftUI
import ReMVVMSwiftUI

struct SearchListView: View {
    
    var sampleSources = ["a", "b", "c", "d"]
    @State private var searchText = ""
    
    @ReMVVM.ViewModel private var viewModel: SearchListViewModel!
    
    var body: some View {
        NavigationView{
            List(sampleSources, id: \.self){
                source in
                Text(source + searchText + " " + String(viewModel.total))
            }
            .listStyle(.plain)
            .navigationTitle("タイトル")
            .searchable(text: $searchText,
                        placement: .navigationBarDrawer(displayMode: .always))
            .onChange(of: searchText) { newValue in
                debugPrint("newValue: \(newValue)")
                debugPrint("searchText: \(searchText)")
                // videModelにデータを渡す
                viewModel.requestRepositories(keyword: newValue)
            }
        }
    }
}

struct SearchListView_Previews: PreviewProvider {
    static var previews: some View {
        SearchListView()
    }
}
