//
//  Movie.swift
//  test-app-movie
//
//  Created by Элина on 19.11.2020.
//  Copyright © 2020 Элина. All rights reserved.
//

import Foundation

struct Movies: Codable {
    let results: [Movie]
}

class Movie: Codable {
    let title: String
    let poster_path: String?
    let overview: String
    let release_date: String
    let production_companies: [Company]?
    let genre_ids: [Int]?
    let id: Int
    
    init() {
        title = "Example Movie"
        poster_path = nil
        overview = "Very interesting movie"
        release_date = "20-11-2020"
        production_companies =  [Company]()
        genre_ids = [14,28]
        id = 590706
    }
}

struct Company: Codable {
    let name: String
}
