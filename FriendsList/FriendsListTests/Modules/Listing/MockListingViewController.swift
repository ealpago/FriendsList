//
//  MockListingViewController.swift
//  FriendsListTests
//
//  Created by Emre Alpago on 1.10.2024.
//

@testable import FriendsList

final class MockListingViewController: ListingViewInterface {
    func hideNavBar() { }
    
    func prepareTableView() {  }
    
    func reloadData() { }
    
    func pushVC(argument: FriendsList.DetailViewArguments?) {  }
    
    func showError(title: String, message: String, buttonTitle: String, completion: @escaping () -> ()) {

    }
    
    func showLoadingIndicator() {

    }
    
    func hideLoadingIndicator() {
        
    }
}
