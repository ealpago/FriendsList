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

//MARK: ViewModel
final class DetailViewModel {

    //MARK: Properties
    weak var view: DetailViewInterface?
}

//MARK: Extension
extension DetailViewModel: DetailViewModelInterface {
    func viewDidLoad() {
        view?.prepareUIConstraints()
        view?.prepareUIData()
        view?.prepareMapKit()
    }
}
