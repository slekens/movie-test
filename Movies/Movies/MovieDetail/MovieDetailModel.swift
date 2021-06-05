//
//  MovieDetailModel.swift
//  Movies
//
//  Created by Abraham Abreu on 04/06/21.
//

import Foundation

struct MovieDetailModel: Codable, Identifiable {
    var id: Int = 0
    var adult: Bool = false
    var backdropImage: String? = ""
    var budget: Int = 0
    var genres = [MovieGenre]()
    var homepage: String = ""
    var overview: String = ""
    var popularity: Double = 0.0
    var posterImage: String? = ""
    var releaseDate: String = ""
    var revenue: Int = 0
    var voteAverage: Double = 0.0
    var voteCount: Int = 0
    /// Coding keys to set the correct names in the api.
    enum CodingKeys: String, CodingKey {
        case id
        case adult
        case backdropImage = "backdrop_path"
        case budget
        case genres
        case homepage
        case overview
        case popularity
        case posterImage = "poster_path"
        case releaseDate = "release_date"
        case revenue
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

struct MovieGenre: Codable, Hashable {
    var id: Int = 0
    var name: String = ""
    /// Coding keys to set the correct names in the api.
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}

struct CastList: Codable {
    var id: Int = 0
    var cast = [Cast]()
    /// Coding keys to set the correct names in the api.
    enum CodingKeys: String, CodingKey {
        case id
        case cast
    }
}

struct Cast: Codable, Identifiable {
    var id: Int = 0
    var name: String = ""
    var character: String = ""
    var popularity: Double = 0.0
    var profilePicture: String? = ""
    /// Coding keys to set the correct names in the api.
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case character
        case popularity
        case profilePicture = "profile_path"
    }
}

struct Videos: Codable {
    var id: Int = 0
    var results = [Video]()
}

struct Video: Codable, Identifiable {
    var id: String = ""
    var name: String = ""
}
