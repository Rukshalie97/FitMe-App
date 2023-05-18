//
//  ContentView.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-18.
//

import UIKit
import SnapKit

class ContentView: UIViewController {
    let artist = "Your Desired Artist"
    let apiKey = "68c1cc81e0a7ce2be92a4ad3a2281d2c"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        let button = UIButton(type: .system) // Use system button type
        button.setTitle("Search Tracks", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        
        view.backgroundColor = .systemBackground
    }
    
    @objc private func buttonTapped() {
        searchTracks(artist: artist, apiKey: apiKey)
    }
    
    private func searchTracks(artist: String, apiKey: String) {
        let baseURL = "http://ws.audioscrobbler.com/2.0/"
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
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
        
            guard let data = data else {
                print("No data received")
                return
            }
        
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
            }
        }.resume()
    }
}
