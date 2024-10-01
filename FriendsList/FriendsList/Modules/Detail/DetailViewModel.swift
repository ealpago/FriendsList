//
//  DetailViewModel.swift
//  FriendsList
//
//  Created by Emre Alpago on 30.09.2024.
//

import Foundation

//MARK: Protocol
protocol DetailViewModelInterface {
    func viewDidLoad()
}

//MARK: Arguments
struct DetailViewArguments {
    var id: String
    var picture: String?
    var name: String?
    var surname: String?
    var nationality: String?
    var country: String?
    var state: String?
    var city: String?
    var latitude: String?
    var longitude: String?

    var fullName: String {
        guard let name = name, let surname = surname else { return "" }
        return name + " " + surname
    }
}

//MARK: ViewModel
final class DetailViewModel {

    //MARK: Properties
    private weak var view: DetailViewInterface?
    private let arguments: DetailViewArguments

    init(view: DetailViewInterface, arguments: DetailViewArguments) {
        self.view = view
        self.arguments = arguments
    }
}

//MARK: Extension
extension DetailViewModel: DetailViewModelInterface {
    func viewDidLoad() {
        view?.prepareUIConstraints()
        view?.prepareLabels(data: arguments)
        if let imageURL = arguments.picture {
            view?.prepareProfileImage(image: imageURL)
        }
        if let latitude = arguments.latitude, let longitude = arguments.longitude {
            view?.prepareMapKit(latitude: latitude, longitude: longitude)
        }
    }
}
