//
//  Repository+Debug.swift
//  FindGitHubRep
//
//  Created by Mitsuharu Emoto on 2021/12/15.
//

import Foundation

extension SearchRepositoryResult {
    
    /**
     検証など向けのダミーデータ
     */
    static func Dummy(count: Int) -> SearchRepositoryResult? {
        do {
            return try SearchRepositoryResult(
                total: count,
                items: Repository.DummyList(count: count)
            )
        } catch {
            logger.warning("error: \(error)")
            return nil
        }
    }
}


extension Repository {
    
    /**
     検証など向けのダミーデータ
     */
    static func Dummy(id: Int) -> Repository{
        return Repository(
            id: id,
            name: "dummy-name-" + String(id),
            fullName: "Dummpy Name " + String(id),
            url: "https://example.com/",
            description: "it is a dummy data!",
            owner: User.Dummy(),
            stars: 10,
            watchers: 20,
            topics: ["dummy-topic-0", "dummy-topic-1"]
        )
    }
    
    /**
     検証など向けのダミーデータ
     */
    static func DummyList(count: Int) throws -> [Repository] {
        
        if (count <= 0){
            throw NSError(domain: "引数は正の整数のみです", code: -1, userInfo: nil)
        }
        
        return Array(0...count).map{
            Repository.Dummy(id: $0)
        }
    }
}

extension User {
    
    /**
     検証など向けのダミーデータ
     */
    static func Dummy() -> User{
        return User(
            id: 1,
            name: "dummy user name",
            avatarUrl: "https://httpbin.org/image/png",
            url: "https://example.com/"
        )
    }
}
    
