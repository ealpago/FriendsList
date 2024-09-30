//
//  ListingViewController.swift
//  FriendsList
//
//  Created by Emre Alpago on 30.09.2024.
//

import UIKit

protocol ListingViewInterface: AnyObject, AlertPresentable, ProgressIndicatorPresentable {
    func popToRoot()
    func prepareTableView()
    func reloadData()
    func pushVC(argument: DetailViewArguments?)
}

final class ListingViewController: UIViewController {
    @IBOutlet private weak var usersTableView: UITableView!

    private lazy var viewModel = ListingViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

extension ListingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRowsInSection
    }
}

extension ListingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier) as? UserTableViewCell else { return UITableViewCell() }
        cell.configure(argument: viewModel.cellForRow(at: indexPath.row))
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didSelectRow(at: indexPath.row)
    }
}

extension ListingViewController: ListingViewInterface {
    func prepareTableView() {
        usersTableView.delegate = self
        usersTableView.dataSource = self
        usersTableView.register(UserTableViewCell.nib, forCellReuseIdentifier: UserTableViewCell.identifier)
    }

    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            usersTableView.reloadData()
        }
    }

    func pushVC(argument: DetailViewArguments?) {
        if let vc = "DetailStoryboard".viewController(identifier: DetailViewController.identifier) as? DetailViewController {
            vc.arguments = argument
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    func popToRoot() {
        navigationController?.popViewController(animated: true)
    }
}
