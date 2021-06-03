//
//  ServicesAPI.swift
//  Movies
//
//  Created by Abraham Abreu on 03/06/21.
//

import Foundation
import Combine

enum Constants {
    static let apiKey: String = "dcdd37442148f79b3e9aeec690e825a5"
}

enum MovieAPI {
    static let servicesClient: ServicesClient = ServicesClient()
    static let baseURL: String = "https://api.themoviedb.org/3/"
}

enum Path: String {
    case popular = "movie/popular"
    case upcomming = "movie/upcoming"
    case topRated = "movie/top_rated"
}

extension MovieAPI {
    static func requestMovieList(_ path: Path, page: Int) -> AnyPublisher<MovieList, Error> {
        guard let url = URL(string: baseURL) else { fatalError("We can't create URL") }
        guard var components = URLComponents(url: url.appendingPathComponent(path.rawValue), resolvingAgainstBaseURL: true) else { fatalError("We can't create url components")}
        components.queryItems = [
            URLQueryItem(name: "api_key", value: Constants.apiKey),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        guard let completeURL = components.url else { fatalError("We can't create the complete url")}
        let request = URLRequest(url: completeURL)
        return servicesClient.fetch(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
