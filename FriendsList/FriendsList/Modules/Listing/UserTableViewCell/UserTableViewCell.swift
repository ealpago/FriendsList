//
//  UserTableViewCell.swift
//  FriendsList
//
//  Created by Emre Alpago on 30.09.2024.
//

import UIKit

struct ListingViewCellArguments {
    var picture: String?
    var name: String?
    var surname: String?
    var nationality: String?

    var fullName: String {
        guard let name = name, let surname = surname else { return "" }
        return name + " " + surname
    }
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

    func configure(argument: ListingViewCellArguments) {
        nameLabel.text = argument.fullName
        nationalityLabel.text = argument.nationality
        guard let url = argument.picture else { return }
        profileImageView.setImage(from: url)
    }
}
