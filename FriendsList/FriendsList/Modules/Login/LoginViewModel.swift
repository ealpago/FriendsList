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
        guard let userName = view?.userName, let password = view?.password else {
            view?.showError(title: "Error", message: "check", buttonTitle: "OK", completion: {})
            return
        }
        view?.pushVC()
    }
}
