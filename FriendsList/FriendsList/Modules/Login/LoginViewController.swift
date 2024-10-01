//
//  LoginViewController.swift
//  FriendsList
//
//  Created by Emre Alpago on 30.09.2024.
//

import UIKit

//MARK: Protocol
protocol LoginViewInterface: AlertPresentable {
    var userName: String { get }
    var password: String { get }

    func addTapGestureToSuperView()
    func setTextFieldDelegate()
    func endEditing()
    func setLoginButtonEnable(isEnable: Bool)
    func pushVC()
}

//MARK: ViewController
extension LoginViewController {
    enum Constant {
        static let listingStoryboardFileName = "ListingStoryboard"
    }
}

final class LoginViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var userNameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!

    //MARK: Properties
    private lazy var viewModel = LoginViewModel(view: self)

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }

    @objc func dismissKeyboard() {
        viewModel.dismissKeyboard()
    }

    //MARK: Actions
    @IBAction private func loginButtonTappped() {
        viewModel.loginButtonTapped()
    }
}

//MARK: TextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing() {
        viewModel.textFieldDidBeginEditing()
    }

    func textFieldDidEndEditing() {
        viewModel.textFieldDidEndEditing()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK: Extension
extension LoginViewController: LoginViewInterface {
    var userName: String {
        userNameTextField.text ?? ""
    }

    var password: String {
        passwordTextField.text ?? ""
    }

    func addTapGestureToSuperView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    func setTextFieldDelegate() {
        userNameTextField.delegate = self
        passwordTextField.delegate = self
    }

    func endEditing() {
        view.endEditing(true)
    }

    func setLoginButtonEnable(isEnable: Bool) {
        loginButton.isUserInteractionEnabled = isEnable
    }

    func pushVC() {
        guard let vc = Constant.listingStoryboardFileName.viewController(identifier: ListingViewController.identifier) as? ListingViewController else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
}
