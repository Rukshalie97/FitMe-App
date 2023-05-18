//
//  SelectMusicProviderViewController.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-18.
//

import UIKit
import SnapKit

class SelectMusicProviderViewController: UIViewController {

    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("Search Tracks", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hexString: "#007AFF")
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        view.backgroundColor = .white

        view.addSubview(searchButton)
        searchButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(48)
        }
    }

    @objc private func searchButtonTapped() {
        let artist = "Martin Briley"
        let apiKey = "68c1cc81e0a7ce2be92a4ad3a2281d2c"

        let baseURL = "https://ws.audioscrobbler.com/2.0/"
        let queryItems = [
            URLQueryItem(name: "method", value: "track.search"),
            URLQueryItem(name: "artist", value: artist),
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "format", value: "json")
        ]
        var urlComponents = URLComponents(string: baseURL)
        urlComponents?.queryItems = queryItems

        guard let url = urlComponents?.url else {
            print("Invalid URL")
            return
        }

        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }

            guard let data = data else {
                print("No data received")
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]

                if let results = json?["results"] as? [String: Any],
                   let trackMatches = results["trackmatches"] as? [String: Any],
                   let tracks = trackMatches["track"] as? [[String: Any]] {
                    for track in tracks {
                        if let name = track["name"] as? String,
                           let artist = track["artist"] as? String,
                           let url = track["url"] as? String {
                            print("Track: \(name), Artist: \(artist), URL: \(url)")
                        }
                    }
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
