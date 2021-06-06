//
//  MovieDetailModel.swift
//  Movies
//
//  Created by Abraham Abreu on 04/06/21.
//

import Foundation
/// Movie detail information
struct MovieDetailModel: Codable, Identifiable {
    /// Movie id
    var id: Int = 0
    /// Movie genres
    var genres = [MovieGenre]()
    /// Movie resume
    var overview: String = ""
    /// Movie release date
    var releaseDate: String = ""
    /// Vote average count
    var voteAverage: Double = 0.0
    /// Vote count
    var voteCount: Int = 0
    /// Coding keys to set the correct names in the api.
    enum CodingKeys: String, CodingKey {
        case id
        case genres
        case overview
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
/// Movie genres
struct MovieGenre: Codable, Hashable {
    /// Genre id
    var id: Int = 0
    /// Genre name
    var name: String = ""
    /// Coding keys to set the correct names in the api.
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
/// Movie cast list
struct CastList: Codable {
    /// Cast id list
    var id: Int = 0
    /// Cast list
    var cast = [Cast]()
    /// Coding keys to set the correct names in the api.
    enum CodingKeys: String, CodingKey {
        case id
        case cast
    }
}
/// Movie cast object
struct Cast: Codable, Identifiable {
    /// Cast id
    var id: Int = 0
    /// Cast name
    var name: String = ""
    /// Cast character name
    var character: String = ""
    /// Cast picture
    var profilePicture: String? = ""
    /// Coding keys to set the correct names in the api.
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case character
        case profilePicture = "profile_path"
    }
}
/// Movie videos list
struct Videos: Codable {
    /// Video list id
    var id: Int = 0
    /// Video list
    var results = [Video]()
}
/// Movie video object
struct Video: Codable, Identifiable {
    /// Video id
    var id: String = ""
    /// Video name
    var name: String = ""
    /// Video key for youtube.
    var key: String = ""
}
