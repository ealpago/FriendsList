//
//  LoginViewModel.swift
//  FriendsList
//
//  Created by Emre Alpago on 30.09.2024.
//

import Foundation

//MARK: Protocol
protocol LoginViewModelInterface {
    func viewDidLoad()
    func loginButtonTapped()
}

//MARK: ViewModel
final class LoginViewModel {

    //MARK: Properties
    weak var view: LoginViewInterface?
}

//MARK: Extension
extension LoginViewModel: LoginViewModelInterface {
    func viewDidLoad() {}

    func loginButtonTapped() {
        guard let userName = view?.userName, !userName.isEmpty, let password = view?.password, !password.isEmpty else {
            view?.showError(title: "Alert", message: "Username or Password is nil", buttonTitle: "OK", completion: {})
            return
        }
        view?.pushVC()
    }
}
