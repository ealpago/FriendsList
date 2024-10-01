//
//  ListingViewModel.swift
//  FriendsList
//
//  Created by Emre Alpago on 30.09.2024.
//

import Foundation

//MARK: Protocol
protocol ListingViewModelInterface {
    var numberOfRowsInSection: Int { get }

    func viewDidLoad()
    func viewWillApperar()
    func cellForRow(at index: Int) -> ListingViewCellArguments
    func didSelectRow(at index: Int)
}

//MARK: ViewModel
final class ListingViewModel {

    //MARK: Properties
    weak var view: ListingViewInterface?
    private var users = [ResponseResult]()
    private var realmUsers = [CachedUser]()
    private var isOnline: Bool = true

    //MARK: Functions
    func fetchData(completion: @escaping(Bool)->()) {
        view?.showLoadingIndicator()
        RandomUserManager.shared.fetchRandomUser { [weak self] result in
            self?.view?.hideLoadingIndicator()
            switch result {
            case .success(let response):
                guard let userList = response.results else { return }
                self?.users = userList
                self?.saveDataToRealm(users: userList)
                completion(true)
            case .failure(let error):
                DispatchQueue.main.async {
                    let cachedUsers = RealmManager.shared.fetchUsersFromRealm()
                    if !cachedUsers.isEmpty {
                        self?.realmUsers = cachedUsers
                        completion(false)
                    } else {
                        self?.view?.showError(title: "Error", message: error.localizedDescription, buttonTitle: "OK", completion: {})
                    }
                }
            }
        }
    }

    func saveDataToRealm(users: [ResponseResult]) {
        DispatchQueue.main.async {
            users.forEach { user in
                RealmManager.shared.saveUserToRealm(user: user)
            }
        }
    }
}

//MARK: Extension
extension ListingViewModel: ListingViewModelInterface{
    func viewDidLoad() {
        view?.hideNavBar()
        view?.prepareTableView()
    }

    func viewWillApperar() {
        fetchData() { isOnline in
            self.isOnline = isOnline
            self.view?.reloadData()
        }
    }

    var numberOfRowsInSection: Int {
        isOnline ? users.count : realmUsers.count
    }

    func cellForRow(at index: Int) -> ListingViewCellArguments {
        guard let name = isOnline ? users[index].name?.first : realmUsers[index].name, let surname = isOnline ? users[index].name?.last : realmUsers[index].surname, let nationality = isOnline ? users[index].nat : realmUsers[index].nationality, let picture = isOnline ? users[index].picture?.thumbnail : realmUsers[index].imageURL else { return ListingViewCellArguments() }
        return ListingViewCellArguments(picture: picture, name: name, surname: surname, nationality: nationality)
    }

    func didSelectRow(at index: Int) {
        guard isOnline else {
            DispatchQueue.main.async {
                self.view?.showError(title: "Error", message: "No Connection", buttonTitle: "OK", completion: {})
            }
            return
        }
        guard let name = users[index].name?.first, let surname = users[index].name?.last, let nationality = users[index].nat, let picture = users[index].picture?.thumbnail, let id = users[index].id, let location = users[index].location else { return }
        let argument = DetailViewArguments(picture: picture, name: name, surname: surname, id: id, nationality: nationality,location: location )
        view?.pushVC(argument: argument)
    }
}
