//
//  WokoutModel.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-20.
//

import Foundation
import UIKit

struct WorkoutModel: Codable {
    let id, name, duration, video: String
    let description: String
    let category: Category
    let level, gender, goal, createdAt: String
    let updatedAt: String
    let image : String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, duration, video, description, category, level, gender, goal, createdAt, updatedAt, image
    }
}

// MARK: - Category
struct Category: Codable {
    let id, name, icon, createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, icon, createdAt, updatedAt
    }
}
