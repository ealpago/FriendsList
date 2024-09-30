//
//  LoginViewModel.swift
//  FriendsList
//
//  Created by Emre Alpago on 30.09.2024.
//

import Foundation

protocol LoginViewModelInterface {
    func viewDidLoad()
    func loginButtonTapped()
}

final class LoginViewModel {
    weak var view: LoginViewInterface?
}

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
