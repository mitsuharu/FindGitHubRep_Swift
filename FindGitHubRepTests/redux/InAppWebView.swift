//
//  InAppSafariView.swift
//  FindGitHubRepTests
//
//  Created by Mitsuharu Emoto on 2022/01/29.
//

import XCTest
@testable import FindGitHubRep

class InAppWebView: XCTestCase {

    let mockUrl = "https://example.com/"

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testReducerShow() throws {
        let state = InAppWebState(item: nil)
        let nextState = InAppReducers(action: .show(url: mockUrl), state: state)
        XCTAssertEqual(nextState.item?.url, mockUrl)
    }

    func testReducerClear() throws {
        let state = InAppWebState(item: InAppWebItem(id: 1234, url: mockUrl))
        let nextState = InAppReducers(action: .clear, state: state)
        XCTAssertNil(nextState.item)
    }

}
