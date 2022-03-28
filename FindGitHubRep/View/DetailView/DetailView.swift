//
//  DetailView.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2022/03/26.
//

import SwiftUI
import ReMVVMSwiftUI
import MarkdownUI

private protocol DetailViewProps {
    var repository: Repository! { get }
}

private protocol DetailViewComponentProps: DetailViewProps {
    var textMarkdown: String! { get }
    var requestStatusMarkdown: RequestStatus! { get }
    var onPressWebView: (_ url: String? ) -> Void { get }
}

private struct Component: View, DetailViewComponentProps {

    let repository: Repository!
    let textMarkdown: String!
    let requestStatusMarkdown: RequestStatus!
    let onPressWebView: (String?) -> Void

    var body: some View {
        ScrollView {
            HStack {
                RemoteImageView(url: repository.owner.avatarUrl).frame(width: 40, height: 40)
                Text(repository.owner.name).font(.body)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 12)

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
                switch requestStatusMarkdown {
                case .success:
                    Markdown(textMarkdown)
                        .onOpenMarkdownLink { url in
                            onPressWebView(url.absoluteString)
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
                onPressWebView(nil)
            })
        )
    }
}

struct DetailView: View, DetailViewProps, Sendable {

    let repository: Repository!
    @ReMVVM.ViewModel private var viewModel: DetailViewModel!
    @ObservedObject private var navigationService = NavigationService()

    func onPressWebView(_ url: String?) {
        viewModel.openInAppSafariView(url: url ?? repository.url)
    }

    var body: some View {
        NavigationServiceView(navigationService) {
            Component(repository: repository,
                      textMarkdown: viewModel.textMarkdown,
                      requestStatusMarkdown: viewModel.requestStatusMarkdown,
                      onPressWebView: onPressWebView)
        }.onAppear {
            Task {
                if self.viewModel.requestStatusMarkdown != .success {
                    self.viewModel.requestMarkdown(repository: self.repository)
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
