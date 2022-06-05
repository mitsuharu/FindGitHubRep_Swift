//
//  Toast.swift
//  FindGitHubRepTests
//
//  Created by Mitsuharu Emoto on 2022/01/29.
//

import XCTest
@testable import FindGitHubRep

class Toast: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testReducerEnqueueToast() throws {
        let state = ToastState(items: [])
        let message = "test_message"
        let nextState = toastReducer(action: .enqueueToast(message: message, type: nil), state: state)
        XCTAssertEqual(nextState.items.count, state.items.count + 1)
        XCTAssertEqual(nextState.items.last?.message, message)
    }

    func testReducerDequeueToast() throws {
        let itemId = 1234
        let item = ToastItem(id: itemId, message: "test", type: .info)
        let state = ToastState(items: [item])
        let nextState = toastReducer(action: .dequeueToast(id: itemId), state: state)
        XCTAssertEqual(nextState.items.count, state.items.count - 1)

        let nextItem: ToastItem? = nextState.items.first { it in
            it.id == itemId
        }
        XCTAssertNil(nextItem)
    }

    func testReducerClearToast() throws {
        let item = ToastItem(id: 1234, message: "test", type: .info)
        let state = ToastState(items: [item])
        let nextState = toastReducer(action: .clearToast, state: state)
        XCTAssertEqual(nextState.items.count, 0)
    }

}
