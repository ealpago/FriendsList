//
//  UserTableViewCell.swift
//  FriendsList
//
//  Created by Emre Alpago on 30.09.2024.
//

import UIKit

struct ListingViewArguments {
    var picture: String?
    var name: String?
    var nationality: String?
}

class UserTableViewCell: UITableViewCell {

    @IBOutlet private weak var mainStackView: UIStackView!
    @IBOutlet private weak var imagecontainerView: UIView!
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var infosStackView: UIStackView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var nationalityLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(argument: ListingViewArguments) {
        nameLabel.text = argument.name
        nationalityLabel.text = argument.nationality
        guard let url = argument.picture else { return }
        profileImageView.setImage(from: url)
    }
}
