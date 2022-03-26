//
//  DetailView.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2022/03/26.
//

import SwiftUI
import ReMVVMSwiftUI
import MarkdownUI

struct DetailView: View, Sendable {

    let repository: Repository!
    @ReMVVM.ViewModel private var viewModel: DetailViewModel!

    var body: some View {
        ScrollView {
            if let str = repository.description {
                Text(str)
                    .font(.body).lineLimit(3).padding(.top, 1.0)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(EdgeInsets(top: 4, leading: 12, bottom: 4, trailing: 12))
            }

            HStack {
                Image(systemName: "star.fill").foregroundColor(.yellow)
                Text("\(repository.stars)").font(.subheadline)
                Spacer().frame(width: 10)
                Image(systemName: "eye.fill").foregroundColor(.gray)
                Text("\(repository.watchers)").font(.subheadline)
            }.padding(.top, 2.0).frame(maxWidth: .infinity, alignment: .leading).padding(.all, 12.0)

            Spacer().frame(width: 30)

            Text("トピック").bold().font(.title2).frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal, 8.0)
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
            }.padding(.horizontal, 8.0)

            Spacer().frame(width: 30)

            Text("Readme").bold().font(.title2).frame(maxWidth: .infinity, alignment: .leading).padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
            ZStack {
                switch viewModel.requestStatusMarkdown {
                case .success:
                    Markdown(viewModel.markdown)
                        .onOpenMarkdownLink { url in
                            viewModel.openInAppSafariView(url: url.absoluteString)
                        }
                        .padding(.horizontal, 8.0)
                case .faild:
                    Text("readme の読み込みに失敗しました")
                case .loading:
                    ProgressView()
                        .frame(idealWidth: .infinity, maxWidth: .infinity, alignment: .center)
                default:
                    EmptyView()
                }
            }

        }
        .navigationTitle(repository.name)
        .navigationBarItems(
            trailing: Button("WebView", action: {
                viewModel.openInAppSafariView(url: repository.url)
            })
        ).onAppear {
            Task {
                if self.viewModel.requestStatusMarkdown != .success {
                    await self.viewModel.requestMarkdown(repository: self.repository)
                }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(repository: Repository.Dummy(id: 100))
    }
}
