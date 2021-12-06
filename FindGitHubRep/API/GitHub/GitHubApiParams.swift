//
//  Constants.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/11/28.
//

import Foundation
import Alamofire

struct GitHubApiParams {
    static let urlSearchRepositories = "https://api.github.com/search/repositories"
    
    static let headers: HTTPHeaders = ["accept": "application/vnd.github.v3+json"]
    
    /**
     1ページあたりの結果数
     */
    static let LIMIT_PER_PAGE: Int = 30
    
    static func parameters(keyword: String, page: Int) -> [String: Any] {
        return [
            "q": keyword + " in:name",
            "page": page,
            "sort":"stars",
            "per_page": LIMIT_PER_PAGE,
        ]
    }
}


