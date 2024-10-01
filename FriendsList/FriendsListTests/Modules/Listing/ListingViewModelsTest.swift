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
    private var randomUserManager: MockRandomUserManager!

    override func setUp() {
        super.setUp()
        view = .init()
        randomUserManager = .init()
        viewModel = .init(view: view, randomUserManager: randomUserManager)
    }

    override func tearDown() {
        super.tearDown()
    }
    func test_numbberOfRows_whenAppOnline_userCount() {
        viewModel.isAppOnline = true

        XCTAssertEqual(viewModel.isAppOnline, true)
    }

    func test_numbberOfRows_whenAppOffline_realmUsersCount() {
        viewModel.isAppOnline = false

        XCTAssertEqual(viewModel.isAppOnline, false)
    }

    func test_viewDidLoad_InvokesRequiredMethods() {
        //given
        XCTAssertFalse(view.isBarHidden)
        XCTAssertFalse(view.isTableViewInvoke)

        //when
        viewModel.viewDidLoad()

        //then
        XCTAssertEqual(view.barHiddenCount, 1)
        XCTAssertEqual(view.invokeTableViewCount, 1)
    }
}
