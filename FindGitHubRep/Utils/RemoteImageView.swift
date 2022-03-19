//
//  SwiftUIView.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/12/15.
//

import SwiftUI
import Alamofire
import AlamofireImage

/**
 https://developer.apple.com/documentation/swiftui/asyncimage
 iOS 15 から使える AsyncImage() は画像キャッシュを考慮されていない
 */
struct RemoteImageView: View {

    @ObservedObject fileprivate var viewModel: RemoteImageViewModel

    init(url: String) {
        self.viewModel = RemoteImageViewModel(url: url)
    }

    var body: some View {
        if let image = self.viewModel.image {
            Image(uiImage: image).resizable()
        } else if self.viewModel.isLoading {
            ProgressView()
        } else {
            EmptyView()
        }
    }
}

fileprivate final class RemoteImageViewModel: ObservableObject {

    let url: String
    @Published var image: UIImage?
    @Published var isLoading: Bool = false

    init(url: String) {
        self.url = url
        self.download(url: url)
    }

    func download(url: String) {
        self.isLoading = true
        AF.request(url).responseImage { response in
            if case .success(let image) = response.result {
                self.image = image
            } else {
                self.image = nil
            }
            self.isLoading = false
        }
    }
}

struct RemoteImageView_Previews: PreviewProvider {
    static var previews: some View {
        RemoteImageView(url: "https://httpbin.org/image/png")
    }
}
