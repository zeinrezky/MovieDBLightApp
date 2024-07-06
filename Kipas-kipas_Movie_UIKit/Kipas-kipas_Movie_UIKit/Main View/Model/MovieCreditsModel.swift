//
//  MovieCreditsModel.swift
//  Kipas-kipas_Movie_UIKit
//
//  Created by zein rezky chandra on 06/07/24.
//

import Foundation

struct Cast: Codable {
    let id: Int
    let name: String
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case profilePath = "profile_path"
    }
}

struct MovieCreditsResponse: Codable {
    let cast: [Cast]
    
    enum CodingKeys: String, CodingKey {
        case cast = "cast"
    }
}
