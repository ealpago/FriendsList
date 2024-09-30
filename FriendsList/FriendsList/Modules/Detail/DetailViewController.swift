//
//  DetailViewController.swift
//  FriendsList
//
//  Created by Emre Alpago on 30.09.2024.
//

import UIKit
import MapKit

//MARK: Protocol
protocol DetailViewInterface: AnyObject, AlertPresentable {}



final class DetailViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var mainStackView: UIStackView!
    @IBOutlet private weak var topStackView: UIStackView!
    @IBOutlet private weak var imageContainerView: UIView!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var labelsStackView: UIStackView!
    @IBOutlet private weak var fullNameLabel: UILabel!
    @IBOutlet private weak var idLabel: UILabel!
    @IBOutlet private weak var countryLabel: UILabel!
    @IBOutlet private weak var stateLabel: UILabel!
    @IBOutlet private weak var cityLabel: UILabel!
    @IBOutlet private weak var mapContainerView: UIView!
    @IBOutlet private weak var map: MKMapView!

    //MARK: Properties
    private lazy var viewModel = DetailViewModel()

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

//MARK: Extension
extension DetailViewController: DetailViewInterface {}
