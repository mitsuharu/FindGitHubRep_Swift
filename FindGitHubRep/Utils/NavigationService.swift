//
//  NavigationRouter.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2022/03/27.
//

import Foundation
import SwiftUI

/**
 Navigation 遷移を管理する

 FirstView から SecondView に遷移する（lint でインデントが削除・・・）
 ```
 struct FirstView: View {

 @ObservedObject private var navigationService = NavigationService()

 func onPress(_ repo: Repository) {
 navigationService.navigate(AnyView(SecondView()))
 }

 var body: some View {
 NavigationServiceView(navigationService) {
 FirstComponent(onPress: onPress)
 }
 }

 }
 ```
 */

class NavigationService: ObservableObject {
    @Published private(set) var destination: AnyView?
    @Published var isActive = false {
        didSet {
            // NavigationLink で false になったら、不要データの削除
            if !self.isActive {
                self.destination = nil
            }
        }
    }

    func navigate(_ destination: AnyView?) {
        self.destination = destination
        self.isActive = destination != nil
    }
}

struct NavigationServiceView<T: View>: View {

    @ObservedObject private var navigationService: NavigationService
    private let content: () -> T

    public init(_ navigationService: NavigationService, content: @escaping () -> T) {
        self.navigationService = navigationService
        self.content = content
    }

    var body: some View {
        VStack {
            content()
            NavigationLink(
                destination: navigationService.destination,
                isActive: $navigationService.isActive) {
                EmptyView()
            }
        }.environmentObject(navigationService)
    }
}
