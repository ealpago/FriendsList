//
//  DetailViewModel.swift
//  FriendsList
//
//  Created by Emre Alpago on 30.09.2024.
//

import Foundation

protocol DetailViewModelInterface {
    func viewDidLoad()
}

final class DetailViewModel {
    weak var view: DetailViewInterface?
}

extension DetailViewModel: DetailViewModelInterface {
    func viewDidLoad() {
        view?.prepareUIConstraints()
        view?.prepareUIData()
        view?.prepareMapKit()
    }
}
