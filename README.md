FindGitHubRep_Swift
===

- GitHubのレポジトリを検索するアプリです


## 目的

- APIで情報取得してリスト表示するといった、アプリの基本機能を他の言語ではどう書くのだろうか、と思った iOS / Swift 練習用アプリです。
- GitHubのレポジトリ検索は、制約があるが、認証なしで使えるので、token 管理などが不要なため選択した。


## 対象環境

- iOS 15 以上

## 選定アーキテクチャ

- SwiftUI
  - 宣言型UI 	が好きだから
- ReSwift + MVVM
  - Redux が好きだから 
  - Redux + MVVM


### その他

- SwiftLint
	- `% brew install swiftlint`
	- ビルド時に変更ファイルに自動適用