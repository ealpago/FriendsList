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
    func dismissKeyboard()
    func textFieldDidBeginEditing()
    func textFieldDidEndEditing()
    func loginButtonTapped()
}

//MARK: ViewModel
extension LoginViewModel {
    enum Constant {
        static let validUserNameRegexPattern = "^[a-z0-9]{5,7}$"
        static let alertTitle = "Alert"
        static let nilAlertMessage = "Username or Password is nil"
        static let regexErrorMessage = "Username is invalid"
        static let alertButtonTitle = "OK"
    }
}

final class LoginViewModel {
    private weak var view: LoginViewInterface?

    init(view: LoginViewInterface) {
        self.view = view
    }

    private func checkValidUsername(_ userName: String) -> Bool {
        guard let regex = try? NSRegularExpression(pattern: Constant.validUserNameRegexPattern) else { return false }
        let range = NSRange(location: 0, length: userName.utf16.count)
        return regex.firstMatch(in: userName, options: [], range: range) != nil
    }
}

//MARK: Extension
extension LoginViewModel: LoginViewModelInterface {
    func viewDidLoad() {
        view?.addTapGestureToSuperView()
        view?.setTextFieldDelegate()
    }

    func dismissKeyboard() {
        view?.endEditing()
    }

    func textFieldDidBeginEditing() {
        view?.setLoginButtonEnable(isEnable: false)
    }

    func textFieldDidEndEditing() {
        view?.setLoginButtonEnable(isEnable: true)
    }

    func loginButtonTapped() {
        guard let userName = view?.userName, !userName.isEmpty, let password = view?.password, !password.isEmpty else {
            view?.showError(title: Constant.alertTitle, message: Constant.nilAlertMessage, buttonTitle: Constant.alertButtonTitle, completion: {})
            return
        }
        guard checkValidUsername(userName) else {
            view?.showError(title:Constant.alertTitle, message: Constant.regexErrorMessage, buttonTitle: Constant.alertButtonTitle, completion: {})
            return
        }
        view?.pushVC()
    }
}

