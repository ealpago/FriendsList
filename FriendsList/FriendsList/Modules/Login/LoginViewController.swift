//
//  LoginViewController.swift
//  FriendsList
//
//  Created by Emre Alpago on 30.09.2024.
//

import UIKit

protocol LoginViewInterface: AnyObject, AlertPresentable {
    var userName: String { get }
    var password: String { get }

    func pushVC()
}

final class LoginViewController: UIViewController {

    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var userNameTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var loginButton: UIButton!

    //MARK: Properties
    private lazy var viewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }

    @IBAction private func loginButtonTappped(_ sender: UIButton) {
        viewModel.loginButtonTapped()
    }
}

extension LoginViewController: LoginViewInterface {
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
