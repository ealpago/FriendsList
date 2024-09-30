//
//  LoginViewController.swift
//  FriendsList
//
//  Created by Emre Alpago on 30.09.2024.
//

import UIKit

//MARK: Protocol
protocol LoginViewInterface: AnyObject, AlertPresentable {
    var userName: String { get }
    var password: String { get }

    func prepareUI()
    func pushVC()
    func checkValidUsername(_ userName: String) -> Bool
}

//MARK: ViewController
final class LoginViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var userNameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!

    //MARK: Properties
    private lazy var viewModel = LoginViewModel()

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    //MARK: Actions
    @IBAction private func loginButtonTappped(_ sender: UIButton) {
        viewModel.loginButtonTapped()
    }
}

//MARK: TextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        loginButton.isUserInteractionEnabled = false
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        loginButton.isUserInteractionEnabled = true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

//MARK: Extension
extension LoginViewController: LoginViewInterface {
    func prepareUI() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        userNameTextField.delegate = self
        passwordTextField.delegate = self
    }

    func checkValidUsername(_ userName: String) -> Bool {
        let regexPattern = "^[a-z0-9]{5,7}$"
        let regex = try! NSRegularExpression(pattern: regexPattern)
        let range = NSRange(location: 0, length: userName.utf16.count)
        return regex.firstMatch(in: userName, options: [], range: range) != nil
    }
    
    var userName: String {
        userNameTextField.text ?? ""
    }
    
    var password: String {
        passwordTextField.text ?? ""
    }

    func pushVC() {
        guard let vc = "ListingStoryboard".viewController(identifier: ListingViewController.identifier) as? ListingViewController else { return }
        navigationController?.pushViewController(vc, animated: true)
    }
}
