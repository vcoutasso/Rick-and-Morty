//
//  UIImageView+.swift
//  RickAndMorty
//
//  Created by Vinícius Couto on 14/10/21.
//

import UIKit

// Reference: https://stackoverflow.com/a/27712427
extension UIImageView {

    // MARK: - Download + caching

    func downloadRMImage(from url: URL, contentMode mode: ContentMode = .scaleAspectFit, completion: @escaping () -> Void) {
        let client = RMImageClient()

        if let image = client.getImage(forURL: url) {
            self.image = image
        } else {
            downloaded(from: url, contentMode: mode) {
                if let image = self.image {
                    client.setImage(image, forURL: url)
                }
                completion()
            }
        }
    }

    func downloadRMImage(from link: String, contentMode mode: ContentMode = .scaleAspectFit, completion: @escaping () -> Void) {
        guard let url = URL(string: link) else { return }
        downloadRMImage(from: url, contentMode: mode, completion: completion)
    }


    // MARK: - Download images

    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit, completion: @escaping () -> Void) {
        contentMode = mode

        let spinner = addSpinner()

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpURLResponse = response as? HTTPURLResponse,
                  let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                  let data = data, error == nil,
                  let image = UIImage(data: data) else { return }

            if httpURLResponse.statusCode == 200 {
                DispatchQueue.main.async() { [weak self] in
                    self?.removeSpinner(spinner)
                    self?.image = image
                    completion()
                }
            } else {
                print("Got status code \(httpURLResponse.statusCode) from \(url)")
            }
        }.resume()
    }

    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit, completion: @escaping () -> Void) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode, completion: completion)
    }

    // MARK: - Loading spinner

    private func addSpinner() -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        addSubview(spinner)

        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        return spinner
    }

    private func removeSpinner(_ spinner: UIActivityIndicatorView) {
        spinner.stopAnimating()
        spinner.removeFromSuperview()
    }
}
