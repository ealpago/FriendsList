//
//  LoginViewModel.swift
//  FriendsList
//
//  Created by Emre Alpago on 30.09.2024.
//

import Foundation
import RealmSwift

//MARK: Protocol
protocol LoginViewModelInterface {
    func viewDidLoad()
    func loginButtonTapped()
    func cleanCache()
    //butonalrui tasio
}

//MARK: ViewModel
extension LoginViewModel {
    enum Constant {
        static let validUserNameRegexPattern = "^[a-z0-9]{5,7}$"
    }
}

final class LoginViewModel {
    weak var view: LoginViewInterface?

    private func checkValidUsername(_ userName: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: Constant.validUserNameRegexPattern) else { return false }
        let range = NSRange(location: 0, length: userName.utf16.count)
        return regex.firstMatch(in: userName, options: [], range: range) != nil
    }
}

//MARK: Extension
extension LoginViewModel: LoginViewModelInterface {
    func viewDidLoad() {
        view?.prepareUI()
        cleanCache()
    }

    func cleanCache() {
        //temizle
        DispatchQueue.main.async {
            RealmManager.shared.removeRealmCache()
        }
    }

    func loginButtonTapped() {
        guard let userName = view?.userName, !userName.isEmpty, let password = view?.password, !password.isEmpty else {
            view?.showError(title: "Alert", message: "Username or Password is nil", buttonTitle: "OK", completion: {})
            return
        }
        guard checkValidUsername(userName) else {
            view?.showError(title: "Alert", message: "Username is invalid", buttonTitle: "OK", completion: {})
            return
        }
        view?.pushVC()
    }
}

