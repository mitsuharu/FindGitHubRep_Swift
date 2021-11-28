//
//  API.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/28.
//

import Foundation
import Alamofire

class API{
    
    /**
     see: https://docs.github.com/en/rest/reference/search#search-repositories
     */
    @available(iOS 15.0.0, *)
    func searchRepositories(keyword: String, page: Int = 1) async throws -> SearchRepositoryResult{
        return try await withCheckedThrowingContinuation({ continuation in
            AF.request(GitHubApiParams.urlSearchRepositories,
                       method: .get,
                       parameters: GitHubApiParams.parameters(keyword: keyword, page: page),
                       encoding: URLEncoding.default,
                       headers: GitHubApiParams.headers).responseData{ response in
                switch response.result{
                    case .success(let value):
                    do{
                        let result = try JSONDecoder().decode(SearchRepositoryResult.self,
                                                              from: value)
                        continuation.resume(returning: result)
                    }catch{
                        continuation.resume(throwing: error)
                    }
                    return
                case .failure(let error):
                    debugPrint("searchRepositories error:\(error)")
                    continuation.resume(throwing: error)
                    return
                }
            }
        })
    }
}
