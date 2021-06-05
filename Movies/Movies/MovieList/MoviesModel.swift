//
//  MoviesModel.swift
//  Movies
//
//  Created by Abraham Abreu on 02/06/21.
//

import Foundation
// MARK: Movie Models
/// Model for Movie Data
struct MovieList: Codable {
    /// Current page for API.
    var page: Int = 0
    /// Every movie fetched.
    var results: [Movie] = [Movie]()
    /// Coding Keys
    enum CodingKeys: String, CodingKey {
        case page
        case results
    }
}
/// Movie Model
struct Movie: Codable, Hashable, Identifiable {
    /// Unique ID for identify movie.
    var id = UUID()
    /// Poster image.
    var poster: String? = ""
    /// AP Movie identifier.
    var movieID: Int = 0
    /// Movie title.
    var title: String = ""
    /// Overview
    var overview: String = ""
    /// Movie popularity.
    var popularity: Double = 0.0
    /// Vote count.
    var voteCount: Int = 0
    /// Vote average count.
    var voteAverage: Double = 0.0
    /// Coding keys to set the correct names in the api.
    enum CodingKeys: String, CodingKey {
        case poster = "poster_path"
        case movieID = "id"
        case title
        case popularity
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
        case overview
    }
}
