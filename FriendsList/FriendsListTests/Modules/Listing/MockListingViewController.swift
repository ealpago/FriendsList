//
//  MockListingViewController.swift
//  FriendsListTests
//
//  Created by Emre Alpago on 1.10.2024.
//

@testable import FriendsList

final class MockListingViewController: ListingViewInterface {
    var isBarHidden: Bool = false
    var barHiddenCount: Int = 0
    func hideNavBar() {
        isBarHidden = true
        barHiddenCount += 1
    }

    var isTableViewInvoke: Bool = false
    var invokeTableViewCount: Int = 0
    func prepareTableView() {
        isTableViewInvoke = true
        invokeTableViewCount += 1
    }

    var isReloadDataInvoke: Bool = false
    var reloadDataInvokeCount: Int = 0
    func reloadData() {
        isReloadDataInvoke = true
        reloadDataInvokeCount += 1
    }

    var isPushVCInvoked: Bool = false
    var pushVCInvokedCount: Int = 0
    func pushVC(argument: FriendsList.DetailViewArguments) {
        isPushVCInvoked = true
        pushVCInvokedCount += 0
    }

    var isShowErrorInvoked: Bool = false
    var showErrorInvokedCount: Int = 0
    func showError(title: String, message: String, buttonTitle: String, completion: @escaping () -> ()) {
        isShowErrorInvoked = true
        showErrorInvokedCount += 1
    }

    var isShowLoadingIndicatorInvoked: Bool = false
    var showLoadingIndicatorInvokedCount: Int = 0
    func showLoadingIndicator() {
        isShowLoadingIndicatorInvoked = true
        showLoadingIndicatorInvokedCount += 1
    }
    
    var isHideLoadingIndicatorInvoked: Bool = false
    var hideLoadingIndicatorInvokedCount: Int = 0
    func hideLoadingIndicator() {
        isHideLoadingIndicatorInvoked = true
        hideLoadingIndicatorInvokedCount += 1
    }
}
