//
//  RepositoryItem.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/12/15.
//

import SwiftUI

struct RepositoryItem: View {
    
    var repository: Repository
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                RemoteImageView(url: repository.owner.avatarUrl).frame(width: 50, height: 50)
                Text(repository.owner.name)
            }
            Text(repository.name)
            Text(repository.description ?? "")
        }
    }
}

struct RepositoryItem_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryItem(repository: Repository.Dummy())
    }
}
