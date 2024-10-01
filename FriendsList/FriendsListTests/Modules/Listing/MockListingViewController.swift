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

    func reloadData() { }
    
    func pushVC(argument: FriendsList.DetailViewArguments?) {  }
    
    func showError(title: String, message: String, buttonTitle: String, completion: @escaping () -> ()) {}
    
    func showLoadingIndicator() {}
    
    func hideLoadingIndicator() {}
}
