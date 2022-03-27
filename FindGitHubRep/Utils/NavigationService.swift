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

 - RootView 相当で environmentObject として設定して、NavigationLink を制御する
 - 遷移したい箇所で　EnvironmentObject として呼び出し、遷移関数を実行する

 RootView（lint でタブが削除・・・）

 ```
 struct RootView: View {
 @ObservedObject private var nagivationService = NavigationService()
 var body: some View {
 NavigationView {
 VStack {
 MainView()
 NavigationLink(
 destination: nagivationService.destination,
 isActive: $nagivationService.isActive) {
 EmptyView()
 }
 }
 }
 .navigationViewStyle(StackNavigationViewStyle())
 .environmentObject(nagivationService)
 }
 }
 ```

 MainView（lint でタブが削除・・・）
 ```
 struct MainView: View {
 @EnvironmentObject var navigationService: NavigationService
 var body: some View {
 Button(action: {
 navigationService.navigate(destination: AnyView(NextView()))
 }){
 Text("next")
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

    func navigate(destination: AnyView?) {
        self.destination = destination
        self.isActive = destination != nil
    }
}
