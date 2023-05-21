//
//  NetwokManager.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-18.
//


import Foundation
import MBProgressHUD

class NetworkManager {

    static let shared = NetworkManager()

    private init() {}

    func fetchJSONData<T: Decodable>(urlString: String, from view: UIView, decodingType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {

        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.label.text = "Loading..."

        guard let url = URL(string: urlString) else {
            print("Invalid URL.")
            hud.hide(animated: true)
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                hud.hide(animated: true)
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    print("Invalid HTTP Response.")
                    return
                }

                guard let data = data else {
                    print("Invalid Data.")
                    return
                }

                do {
                    let decodedData = try JSONDecoder().decode(decodingType, from: data)
                    completion(.success(decodedData))
                } catch {
                    print("Decoding error: \(error)")
                    completion(.failure(error))
                }
            }
        }

        task.resume()
    }
}
