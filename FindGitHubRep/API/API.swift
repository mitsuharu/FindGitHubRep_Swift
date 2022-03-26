//
//  API.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/28.
//

import Foundation
import Alamofire

class API {

    func delay(sec: Double) async {
        do {
            try await Task.sleep(nanoseconds: UInt64(sec) * 1_000_000_000)
        } catch {
            logger.warning("API#delay error: \(error)")
        }
    }

    /**

     example: https://api.github.com/search/repositories?page=1&per_page=30&q=swift%20in%3Aname&sort=stars

     see: https://docs.github.com/en/rest/reference/search#search-repositories
     */
    func searchRepositories(keyword: String, page: Int = 1) async throws -> SearchRepositoryResult {
        try await withCheckedThrowingContinuation({ continuation in
            AF.request(GitHubApiParams.urlSearchRepositories,
                       method: .get,
                       parameters: GitHubApiParams.parameters(keyword: keyword, page: page),
                       encoding: URLEncoding.default,
                       headers: GitHubApiParams.headers).responseData { response in

                        print(response.request?.url?.absoluteString ?? "")

                        switch response.result {
                        case .success(let value):
                            do {
                                let result = try JSONDecoder().decode(SearchRepositoryResult.self,
                                                                      from: value)
                                continuation.resume(returning: result)
                            } catch {
                                logger.warning("searchRepositories: json, url: \(response.request?.url?.absoluteString ?? ""), value: \(value), error: \(error)")
                                continuation.resume(throwing: error)
                            }
                            return
                        case .failure(let error):
                            logger.warning("searchRepositories:api, url: \(response.request?.url?.absoluteString ?? ""), error:\(error)")
                            continuation.resume(throwing: error)
                            return
                        }
            }
        })
    }

    /**
     https://api.github.com/repos/octocat/hello-world/readme
     https://docs.github.com/ja/rest/reference/repos#get-a-repository-readme
     */
    func requestReadmeDownloadUrl(owner: String, repo: String)  async throws -> String {
        try await withCheckedThrowingContinuation({ continuation in
            AF.request(GitHubApiParams.urlReadme(owner: owner, repo: repo),
                       method: .get,
                       parameters: nil,
                       encoding: URLEncoding.default,
                       headers: GitHubApiParams.headers).responseData { response in

                        print(response.request?.url?.absoluteString ?? "")

                        switch response.result {
                        case .success(let value):
                            print("requestReadmeDownloadUrl, success,  value: \(value)")
                            do {
                                let result = try JSONDecoder().decode(Readme.self,
                                                                      from: value)
                                continuation.resume(returning: result.downloadUrl)
                            } catch {
                                logger.warning("requestReadmeDownloadUrl: json, url: \(response.request?.url?.absoluteString ?? ""), value: \(value), error: \(error)")
                                continuation.resume(throwing: error)
                            }
                            return
                        case .failure(let error):
                            logger.warning("requestReadmeDownloadUrl:api, url: \(response.request?.url?.absoluteString ?? ""), error:\(error)")
                            continuation.resume(throwing: error)
                            return
                        }
            }
        })
    }

    func downloadReadme(url: String)  async throws -> String {
        try await withCheckedThrowingContinuation({ continuation in
            AF.request(url,
                       method: .get,
                       parameters: nil,
                       encoding: URLEncoding.default,
                       headers: nil).responseData { response in
                        switch response.result {
                        case .success(let value):
                            continuation.resume(returning: String(data: value, encoding: .utf8) ?? "")
                            return
                        case .failure(let error):
                            logger.warning("downloadReadme:api, url: \(response.request?.url?.absoluteString ?? ""), error:\(error)")
                            continuation.resume(throwing: error)
                            return
                        }
            }
        })
    }
}
