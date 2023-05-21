//
//  WokoutModel.swift
//  Fit Me
//
//  Created by Rukshalie  on 2023-05-20.
//

import Foundation
import UIKit

struct PersonalWorkoutsModel: Codable {
    let id, name, duration, video: String
    let description, category, level, gender: String
    let goal, createdAt, updatedAt, image: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, duration, video, description, category, level, gender, goal, createdAt, updatedAt, image
    }
}
