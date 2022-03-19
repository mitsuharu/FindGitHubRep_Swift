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
        VStack(alignment: .leading) {
            HStack {
                RemoteImageView(url: repository.owner.avatarUrl).frame(width: 40, height: 40)
                Text(repository.owner.name).font(.body)
            }
            Text(repository.name).bold().font(.title)
            Text(repository.description ?? "")
                .font(.body).lineLimit(3).padding(.top, 1.0)
            HStack {
                Image(systemName: "star.fill").foregroundColor(.yellow)
                Text("\(repository.stars)").font(.subheadline)
                Spacer().frame(width: 10)
                Image(systemName: "eye.fill").foregroundColor(.gray)
                Text("\(repository.watchers)").font(.subheadline)
            }.padding(.top, 2.0)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 6) {
                    ForEach(repository.topics, id: \.self) { str in
                        Text(str)
                            .font(.subheadline).bold().foregroundColor(.gray)
                            .padding(.horizontal, 4.0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 4).stroke(Color.gray, lineWidth: 2)
                            )
                    }
                }
            }.padding(.horizontal, 2.0)

        }
    }
}

struct RepositoryItem_Previews: PreviewProvider {
    static var previews: some View {
        RepositoryItem(repository: Repository.Dummy(id: 0))
    }
}
