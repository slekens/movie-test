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
    var backdrop: String = ""
    var id: Int = 0
    var title: String = ""
    
    enum CodingKeys: String, CodingKey {
        case backdrop = "backdrop_path"
        case id
        case title
    }
}


/*

            "adult": false,
            "backdrop_path": "/auFsy7xWxLHGC3WrVyPEeKNVVUJ.jpg",
            "genre_ids": [
                35,
                80
            ],
            "id": 337404,
            "original_language": "en",
            "original_title": "Cruella",
            "overview": "In 1970s London amidst the punk rock revolution, a young grifter named Estella is determined to make a name for herself with her designs. She befriends a pair of young thieves who appreciate her appetite for mischief, and together they are able to build a life for themselves on the London streets. One day, Estella’s flair for fashion catches the eye of the Baroness von Hellman, a fashion legend who is devastatingly chic and terrifyingly haute. But their relationship sets in motion a course of events and revelations that will cause Estella to embrace her wicked side and become the raucous, fashionable and revenge-bent Cruella.",
            "popularity": 6107.84,
            "poster_path": "/hjS9mH8KvRiGHgjk6VUZH7OT0Ng.jpg",
            "release_date": "2021-05-26",
            "title": "Cruella",
            "video": false,
            "vote_average": 8.8,
            "vote_count": 1415
        },
 */
