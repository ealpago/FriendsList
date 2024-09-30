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
    func prepareUIData()
    func prepareUIConstraints()
    func prepareMapKit()
}

//MARK: Arguments
struct DetailViewArguments {
    var picture: String?
    var name: String?
    var surname: String?
    var id: Id?
    var nationality: String?
    var location: Location?

    var fullName: String {
        guard let name = name, let surname = surname else { return "" }
        return name + " " + surname
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
    private lazy var viewModel = DetailViewModel()
    var arguments: DetailViewArguments?

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

//MARK: Extension
extension DetailViewController: DetailViewInterface {
    func prepareUIConstraints() {
        DispatchQueue.main.async { [weak self] in
            if let self = self {
                let width = view.frame.width
                let height = view.frame.height
                mapViewHeightConstraints.constant = height * 0.3
                mapViewWidthConstraints.constant = width * 0.8
            }
        }
    }

    func prepareUIData() {
        guard let data = arguments else { return }
        if let imageURL = data.picture {
            profileImageView.setImage(from: imageURL)
        }
        fullNameLabel.text = data.fullName
        idLabel.text = data.id?.value
        countryLabel.text = data.location?.country
        stateLabel.text = data.location?.state
        cityLabel.text = data.location?.city
    }

    func prepareMapKit() {
        guard let data = arguments else { return }
        if let latString = data.location?.coordinates?.latitude,
           let lonString = data.location?.coordinates?.longitude,
           let latitude = CLLocationDegrees(latString),
           let longitude = CLLocationDegrees(lonString) {
            let locationCoordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let region = MKCoordinateRegion(center: locationCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            map.setRegion(region, animated: true)
            let annotation = MKPointAnnotation()
            annotation.coordinate = locationCoordinate
            annotation.title = "Current Location"
            map.addAnnotation(annotation)
        } else {
            print("Invalid coordinates")
        }
    }
}
