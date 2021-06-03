//
//  MoviesModel.swift
//  Movies
//
//  Created by Abraham Abreu on 02/06/21.
//

import Foundation

struct MovieList: Codable, Identifiable {
    var id = UUID()
    var page: Int = 0
    var results: [Movie] = [Movie]()
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
    }
}

struct Movie: Codable, Hashable {
    var backdrop: String? = ""
    var movieID: Int = 0
    var title: String = ""
    
    enum CodingKeys: String, CodingKey {
        case backdrop = "backdrop_path"
        case movieID = "id"
        case title
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        backdrop = try container.decodeIfPresent(String.self, forKey: .backdrop)
        title = try container.decode(String.self, forKey: .title)
        movieID = try container.decode(Int.self, forKey: .movieID)
    }
}
