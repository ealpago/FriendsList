//
//  ListingViewModelsTest.swift
//  FriendsListTests
//
//  Created by Emre Alpago on 1.10.2024.
//

import XCTest
@testable import FriendsList

final class ListingViewModelsTest: XCTestCase {
    private var viewModel: ListingViewModel!
    private var view: MockListingViewController!

    override func setUp() {
        super.setUp()
        view = .init()
        viewModel = .init(view: view)
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_numbberOfRows_userCount() {
        viewModel.isAppOnline = true

        XCTAssertEqual(viewModel.isAppOnline, true)
    }

    func test_numbberOfRows_realmUsersCount() {
        viewModel.isAppOnline = false

        XCTAssertEqual(viewModel.isAppOnline, false)
    }
}
