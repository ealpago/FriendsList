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
    private var realmManager: MockRealmManager!


    override func setUp() {
        super.setUp()
        view = .init()
        randomUserManager = .init()
        realmManager = .init()
        viewModel = .init(view: view, randomUserManager: randomUserManager, realmManager: realmManager)
    }

    override func tearDown() {
        super.tearDown()
    }

    //view?.reloadData()
    func test_viewDidLoad_SuccessRandomUser_InvokesRequiredMethods() {
        //given
        randomUserManager.stubbedResponse = .init(info: nil, results: [])
        realmManager.stubbedFetchUsersFromRealmResult = []

        XCTAssertFalse(view.isTableViewInvoke)
        XCTAssertFalse(view.isShowLoadingIndicatorInvoked)
        XCTAssertFalse(randomUserManager.invokeFetchRandomUser)
        XCTAssertFalse(view.isHideLoadingIndicatorInvoked)
        XCTAssertFalse(realmManager.invokedRemoveRealmCache)
        XCTAssertFalse(view.isReloadDataInvoke)

        //when
        viewModel.viewDidLoad()

        //then
        XCTAssertTrue(view.isTableViewInvoke)
        XCTAssertTrue(view.isShowLoadingIndicatorInvoked)
        XCTAssertTrue(randomUserManager.invokeFetchRandomUser)
        XCTAssertTrue(view.isHideLoadingIndicatorInvoked)
        XCTAssertTrue(realmManager.invokedRemoveRealmCache)
        XCTAssertTrue(view.isReloadDataInvoke)
    }

    func test_viewDidLoad_NetworkFailureWithCachedData_UsesCache() {
        randomUserManager.stubbedResponse = nil
        realmManager.stubbedFetchUsersFromRealmResult = [CachedUser()]

        XCTAssertFalse(view.isTableViewInvoke)
        XCTAssertFalse(view.isShowLoadingIndicatorInvoked)
        XCTAssertFalse(randomUserManager.invokeFetchRandomUser)
        XCTAssertFalse(view.isHideLoadingIndicatorInvoked)
        XCTAssertFalse(view.isReloadDataInvoke)

        //when
        viewModel.viewDidLoad()

        //then
        XCTAssertTrue(view.isTableViewInvoke)
        XCTAssertTrue(view.isShowLoadingIndicatorInvoked)
        XCTAssertTrue(randomUserManager.invokeFetchRandomUser)
        XCTAssertTrue(view.isHideLoadingIndicatorInvoked)
        XCTAssertTrue(view.isReloadDataInvoke)
    }

    func test_viewDidLoad_CompleteFailure_ShowsError() {
        randomUserManager.stubbedResponse = nil
        realmManager.stubbedFetchUsersFromRealmResult = nil

        XCTAssertFalse(view.isTableViewInvoke)
        XCTAssertFalse(view.isShowLoadingIndicatorInvoked)
        XCTAssertFalse(randomUserManager.invokeFetchRandomUser)
        XCTAssertFalse(view.isHideLoadingIndicatorInvoked)
        XCTAssertFalse(view.isShowErrorInvoked)
        XCTAssertFalse(view.isReloadDataInvoke)

        //when
        viewModel.viewDidLoad()

        //then
        XCTAssertTrue(view.isTableViewInvoke)
        XCTAssertTrue(view.isShowLoadingIndicatorInvoked)
        XCTAssertTrue(randomUserManager.invokeFetchRandomUser)
        XCTAssertTrue(view.isHideLoadingIndicatorInvoked)
    }
}
