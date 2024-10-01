//
//  DetailViewController.swift
//  FriendsList
//
//  Created by Emre Alpago on 30.09.2024.
//

import UIKit
import MapKit

//MARK: Protocol
protocol DetailViewInterface: AnyObject, AlertPresentable {
    func prepareProfileImage(image: String)
    func prepareLabels(data: DetailViewArguments)
    func prepareUIConstraints()
    func prepareMapKit(latitude: String, longitude: String)
}

extension DetailViewController {
    enum Constant {
        static let currentLocationTitle = "Current Location"
        static let invalidCoordinatesError = "Invalid coordinates"
    }
}

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
    @IBOutlet private weak var mapViewHeightConstraints: NSLayoutConstraint!
    @IBOutlet private weak var mapViewWidthConstraints: NSLayoutConstraint!

    //MARK: Properties
    var viewModel: DetailViewModelInterface!

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}

//MARK: Extension
extension DetailViewController: DetailViewInterface {
    func prepareUIConstraints() {
        let width = view.frame.width
        let height = view.frame.height
        mapViewHeightConstraints.constant = height * 0.3
        mapViewWidthConstraints.constant = width * 0.8
    }

    func prepareProfileImage(image: String) {
        profileImageView.setImage(from: image)
    }

    func prepareLabels(data: DetailViewArguments) {
        fullNameLabel.text = data.fullName
        idLabel.text = data.id
        countryLabel.text = data.country
        stateLabel.text = data.state
        cityLabel.text = data.city
    }

    func prepareMapKit(latitude: String, longitude: String) {
        if let latitude = CLLocationDegrees(latitude),
           let longitude = CLLocationDegrees(longitude) {
            let locationCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let region = MKCoordinateRegion(center: locationCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            map.setRegion(region, animated: true)
            let annotation = MKPointAnnotation()
            annotation.coordinate = locationCoordinate
            annotation.title = Constant.currentLocationTitle
            map.addAnnotation(annotation)
        } else {
            print(Constant.invalidCoordinatesError)
        }
    }
}
