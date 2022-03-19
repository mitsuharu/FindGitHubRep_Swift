//
//  InAppSafariView.swift
//  FindGitHubRepTests
//
//  Created by Mitsuharu Emoto on 2022/01/29.
//

import XCTest
@testable import FindGitHubRep

class InAppSafariView: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testShow() throws {
        let url = "https://example.com/"
        let state: InAppSafariViewState = InAppSafariViewState(item: nil)
        let nextState = InAppSafariViewReducer.reduce(state: state,
                                                      with: .show(url: url))
        XCTAssertEqual(nextState.item?.url, url)
    }

    func testDismiss() throws {
        let url = "https://example.com/"
        let item: InAppSafariViewItem = InAppSafariViewItem(id: 1234, url: url)
        let state: InAppSafariViewState = InAppSafariViewState(item: item)
        let nextState = InAppSafariViewReducer.reduce(state: state,
                                                      with: .dismiss)
        XCTAssertNil(nextState.item)
    }

}
