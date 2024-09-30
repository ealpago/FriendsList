//
//  UIImageView+Extension.swift
//  FriendsList
//
//  Created by Emre Alpago on 30.09.2024.
//

import UIKit

extension UIImageView {
    func setImage(from urlString: String) {
        self.image = nil
        guard let url = URL(string: urlString) else {
            print("Invalid URL string: \(urlString)")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching image: \(error.localizedDescription)")
                return
            }
            guard let data = data, let image = UIImage(data: data) else {
                print("No data or unable to convert data to image.")
                return
            }
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}
