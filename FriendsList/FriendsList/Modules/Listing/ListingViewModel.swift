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
    func viewWillAppear()
    func cellForRow(at index: Int) -> ListingViewCellArguments
    func didSelectRow(at index: Int)
}

extension ListingViewModel {
    enum Constant {
        static let errorTitle = "Error"
        static let buttonTitle = "OK"
    }
}

//MARK: ViewModel
final class ListingViewModel {

    //MARK: Properties
    private weak var view: ListingViewInterface?
    private var users = [ResponseResult]()
    private var realmUsers = [CachedUser]()
    private var isOnline: Bool = false
    private let randomUserManager: RandomUserManagerInterface
    private let realmManager: RealmManagerInterface

    init(view: ListingViewInterface, randomUserManager: RandomUserManagerInterface = RandomUserManager(), realmManager: RealmManagerInterface = RealmManager.shared) {
        self.view = view
        self.randomUserManager = randomUserManager
        self.realmManager = realmManager
    }

    //MARK: Functions
    private func fetchData() {
        view?.showLoadingIndicator()
        randomUserManager.fetchRandomUser { [weak self] result in
            self?.view?.hideLoadingIndicator()
            switch result {
            case .success(let response):
                guard let userList = response.results else { return }
                self?.users = userList
                self?.realmManager.removeRealmCache()
                self?.saveDataToRealm(users: userList)
                self?.isOnline = true
                self?.view?.reloadData()
            case .failure(let error):
                let cachedUsers = RealmManager.shared.fetchUsersFromRealm()
                if !cachedUsers.isEmpty {
                    self?.realmUsers = cachedUsers
                    self?.isOnline = false
                    self?.view?.reloadData()
                } else {
                    self?.view?.showError(title: Constant.errorTitle, message: error.localizedDescription, buttonTitle: Constant.buttonTitle, completion: {})
                }
            }
        }
    }

    private func saveDataToRealm(users: [ResponseResult]) {
        users.forEach { user in
            self.realmManager.saveUserToRealm(user: user)
        }
    }
}

//MARK: Extension
extension ListingViewModel: ListingViewModelInterface {
    func viewDidLoad() {
        view?.prepareTableView()
        fetchData()
    }

    func viewWillAppear() {
        view?.hideNavBar()
    }

    var numberOfRowsInSection: Int {
        return isOnline ? users.count : realmUsers.count
    }

    func cellForRow(at index: Int) -> ListingViewCellArguments {
        if isOnline {
            return ListingViewCellArguments(picture: users[index].picture?.thumbnail, name: users[index].name?.first, surname: users[index].name?.last, nationality: users[index].nat)
        } else {
            return ListingViewCellArguments(picture: realmUsers[index].imageURL, name: realmUsers[index].name, surname: realmUsers[index].surname, nationality: realmUsers[index].nationality)
        }
    }

    func didSelectRow(at index: Int) {
        var argument: DetailViewArguments?
        if isOnline {
            if let name = users[index].name?.first, let surname = users[index].name?.last, let nationality = users[index].nat, let picture = users[index].picture?.thumbnail, let id = users[index].id?.value, let location = users[index].location {
                argument = DetailViewArguments(id: id, picture: picture, name: name, surname: surname, nationality: nationality, country: location.country, state: location.state, city: location.city, latitude: location.coordinates?.latitude, longitude: location.coordinates?.longitude)
            }
        } else {
            argument = DetailViewArguments(id: realmUsers[index].id, picture: realmUsers[index].imageURL, name: realmUsers[index].name, surname: realmUsers[index].surname, nationality: realmUsers[index].nationality, country: realmUsers[index].country, state: realmUsers[index].state, city: realmUsers[index].city, latitude: realmUsers[index].latitude, longitude: realmUsers[index].longitude)
        }
        guard let argument = argument else { return }
        view?.pushVC(argument: argument)
    }
}
