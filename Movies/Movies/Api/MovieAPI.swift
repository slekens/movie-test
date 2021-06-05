//
//  ServicesAPI.swift
//  Movies
//
//  Created by Abraham Abreu on 03/06/21.
//
import Foundation
import Combine
// MARK: - Globals
/// Register Constants
enum Constants {
    /// The API Key to MovieDB
    static let apiKey: String = "dcdd37442148f79b3e9aeec690e825a5"
}
/// Create the client and stablish the main url.
enum MovieAPI {
    /// API Client.
    static let servicesClient: ServicesClient = ServicesClient()
    /// Base MovieDB Url.
    static let baseURL: String = "https://api.themoviedb.org/3/"
    /// Image MovieDB Url.
    static let imageURL: String = "https://image.tmdb.org/t/p/"
}
/// Poster Size
enum PosterSize: String {
    case small = "w92"
    case medium = "w154"
    case cast = "w185"
    case poster = "w342"
    case screen = "w500"
    case bigger = "w750"
    case original = "original"
}
/// All the paths to fetch data from MovieDB.
enum Path: String {
    /// Popular movies path
    case popular = "movie/popular"
    /// Upcomming movies path
    case upcomming = "movie/upcoming"
    /// Top rated movies path
    case topRated = "movie/top_rated"
    /// Movie path
    case movie = "movie/"
}
// MARK: - Request Creation
/// Create all the movieDB Requests.
extension MovieAPI {
    /// Create a Image URL.
    static func createURL(posterSize: PosterSize, imageName: String) -> URL {
        guard let url = URL(string: "\(MovieAPI.imageURL)" + "\(posterSize.rawValue)" + "\(imageName)") else { fatalError("We can't create url") }
        return url
    }
    /// Movie Request creation.
    /// - Parameters:
    ///   - path: We need proviide the path to the api.
    ///   - page: The current page.
    /// - Returns: The current publisher with the data.
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
    /// Fetch movie details.
    /// - Parameter movieID: This is the unique movie identifier.
    /// - Returns: The current publisher with the data.
    static func requestMovieDetail(_ movieID: Int) -> AnyPublisher<MovieDetailModel, Error> {
        guard let url = URL(string: baseURL) else { fatalError("We can't create URL") }
        guard var components = URLComponents(url: url.appendingPathComponent("\(Path.movie.rawValue)"+"\(movieID)"), resolvingAgainstBaseURL: true) else { fatalError("We can't create url components") }
        components.queryItems  = [
            URLQueryItem(name: "api_key", value: Constants.apiKey)
        ]
        guard let completeURL = components.url else { fatalError("We can't create the complete url")}
        let request = URLRequest(url: completeURL)
        return servicesClient.fetch(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    /// Fetch movie credits.
    /// - Parameter movieID: This is the unique movie identifier.
    /// - Returns: The current publisher with the data.
    static func requestMovieCredits(_ movieID: Int) -> AnyPublisher<CastList, Error> {
        guard let url = URL(string: baseURL) else { fatalError("We can't create URL") }
        guard var components = URLComponents(url: url.appendingPathComponent("\(Path.movie.rawValue)"+"\(movieID)/credits"), resolvingAgainstBaseURL: true) else { fatalError("We can't create url components") }
        components.queryItems  = [
            URLQueryItem(name: "api_key", value: Constants.apiKey)
        ]
        guard let completeURL = components.url else { fatalError("We can't create the complete url")}
        let request = URLRequest(url: completeURL)
        return servicesClient.fetch(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    /// Fetch movie videos.
    /// - Parameter movieID: This is the unique movie identifier.
    /// - Returns: The current publisher with the data.
    static func requestMovieVideos(_ movieID: Int) -> AnyPublisher<Videos, Error> {
        guard let url = URL(string: baseURL) else { fatalError("We can't create URL") }
        guard var components = URLComponents(url: url.appendingPathComponent("\(Path.movie.rawValue)"+"\(movieID)/videos"), resolvingAgainstBaseURL: true) else { fatalError("We can't create url components") }
        components.queryItems  = [
            URLQueryItem(name: "api_key", value: Constants.apiKey)
        ]
        guard let completeURL = components.url else { fatalError("We can't create the complete url")}
        let request = URLRequest(url: completeURL)
        return servicesClient.fetch(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
