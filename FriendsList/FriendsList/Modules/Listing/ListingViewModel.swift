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
    func cellForRow(at index: Int) -> ListingViewCellArguments
    func didSelectRow(at index: Int)
}

final class ListingViewModel {
    weak var view: ListingViewInterface?
    private var users = [ResponseResult]()

    func fetchData(completion: @escaping()->()) {
        view?.showLoadingIndicator()
        RandomUserManager.shared.fetchRandomUser { [weak self] result in
            self?.view?.hideLoadingIndicator()
            switch result {
            case .success(let response):
                guard let userList = response.results else { return }
                self?.users = userList
                completion()
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.view?.showError(title: "Error", message: error.localizedDescription, buttonTitle: "OK", completion: {
                        self?.view?.popToRoot()
                    })
                }
            }
        }
    }
}

extension ListingViewModel: ListingViewModelInterface{
    func viewDidLoad() {
        view?.prepareTableView()
        fetchData() {
            self.view?.reloadData()
        }
    }
    
    var numberOfRowsInSection: Int {
        users.count
    }

    func cellForRow(at index: Int) -> ListingViewCellArguments {
        guard let name = users[index].name?.first, let surname = users[index].name?.last, let nationality = users[index].nat, let picture = users[index].picture?.thumbnail else { return ListingViewCellArguments() }
        return ListingViewCellArguments(picture: picture, name: name, surname: surname, nationality: nationality)
    }

    func didSelectRow(at index: Int) {
        guard let name = users[index].name?.first, let surname = users[index].name?.last, let nationality = users[index].nat, let picture = users[index].picture?.thumbnail, let id = users[index].id, let location = users[index].location else { return }
        let argument = DetailViewArguments(picture: picture, name: name, surname: surname, id: id, nationality: nationality,location: location )
        view?.pushVC(argument: argument)
    }
}
