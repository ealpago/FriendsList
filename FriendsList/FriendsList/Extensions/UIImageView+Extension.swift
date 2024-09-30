//
//  UIImageView+Extension.swift
//  FriendsList
//
//  Created by Emre Alpago on 30.09.2024.
//

import UIKit

extension UIImageView {
    func setImage(from urlString: String) {
        // Clear the current image to avoid flickering
        self.image = nil

        // Ensure the URL is valid
        guard let url = URL(string: urlString) else {
            print("Invalid URL string: \(urlString)")
            return
        }

        // Create a URLSession data task to fetch the image
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            // Check for errors
            if let error = error {
                print("Error fetching image: \(error.localizedDescription)")
                return
            }

            // Check if data is received
            guard let data = data, let image = UIImage(data: data) else {
                print("No data or unable to convert data to image.")
                return
            }

            // Update the image on the main thread
            DispatchQueue.main.async {
                self.image = image
            }
        }

        // Start the data task
        task.resume()
    }
}
