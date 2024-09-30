//
//  String+Extension.swift
//  FriendsList
//
//  Created by Emre Alpago on 30.09.2024.
//

import UIKit

extension String {
    public var storyBoard: UIStoryboard {
        UIStoryboard(name: self, bundle: nil)
    }

    public func viewController(identifier: String) -> UIViewController {
        storyBoard.instantiateViewController(withIdentifier: identifier)
    }

    public var initialViewController: UIViewController {
        storyBoard.instantiateInitialViewController()!
    }

    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // The date format
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0) // UTC time zone
        return dateFormatter.date(from: self)
    }
}
