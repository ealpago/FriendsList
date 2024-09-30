//
//  ListingViewModel.swift
//  FriendsList
//
//  Created by Emre Alpago on 30.09.2024.
//

import Foundation

protocol ListingViewModelInterface {
    var numberOfRowsInSection: Int { get }

    func viewDidLoad()
    func cellForRow(at index: Int)
}

final class ListingViewModel {
    weak var view: ListingViewInterface?
    private var users = [ResponseResult]()

    func fetchData() {
        view?.showLoadingIndicator()
        RandomUserManager.shared.fetchRandomUser { [weak self] result in
            self?.view?.hideLoadingIndicator()
            switch result {
            case .success(let response):
                guard let userList = response.results else { return }
                self?.users = userList
            case .failure(let error):
                self?.view?.showError(title: "Error", message: error.localizedDescription, buttonTitle: "OK", completion: {
                    self?.view?.popToRoot()
                })
            }
        }
    }
}

extension ListingViewModel: ListingViewModelInterface{
    func viewDidLoad() {
        view?.prepareTableView()
        fetchData()
        view?.reloadData()
    }
    
    var numberOfRowsInSection: Int {
        users.count
    }
    
    func cellForRow(at index: Int) {}
}
