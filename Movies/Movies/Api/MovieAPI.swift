//
//  ServicesAPI.swift
//  Movies
//
//  Created by Abraham Abreu on 03/06/21.
//
import Foundation
import Combine
import AVKit
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
    /// Method to transform category to human readable.
    /// - returns: The localized string for category name.
    func createTitle() -> String {
        switch self {
        case .popular:
            return NSLocalizedString("LABEL_SHEET_OPTION_POPULAR", comment: "")
        case .upcomming:
            return NSLocalizedString("LABEL_SHEET_OPTION_UPCOMMING", comment: "")
        case .topRated:
            return NSLocalizedString("LABEL_SHEET_OPTION_TOP_RATED", comment: "")
        case .movie:
            return ""
        }
    }
}
// MARK: - Request Creation
/// Create all the movieDB Requests.
extension MovieAPI {
    /// Create the language identifier.
    static func createLanguageCode() -> String {
        let langCode = Locale.current
        #if targetEnvironment(simulator)
            let language = "en-US"
        #else
            let language = "\(langCode.identifier)"
        #endif
        return language
    }
    /// Create an Image URL.
    /// - parameter posterSize: Is the image size.
    /// - parameter imageName: Is the name for the image.
    /// - returns: The complete url if is valid.
    static func createURL(posterSize: PosterSize, imageName: String) -> URL {
        guard let url = URL(string: "\(MovieAPI.imageURL)" + "\(posterSize.rawValue)" + "\(imageName)") else { fatalError("URL_CREATION_ERROR") }
        return url
    }
    /// Create a videoPlayer
    /// - parameter key: This is the key for youtube video.
    /// - returns: The AVPlayer object with the youtube url.
    static func createVideoPlayer(key: String) -> AVPlayer {
        guard let urlVideo = URL(string: "https://www.youtube.com/watch?v=\(key)") else { fatalError("URL_CREATION_ERROR") }
        return AVPlayer(url: urlVideo)
    }
    /// Movie Request creation.
    /// - Parameters:
    ///   - path: We need proviide the path to the api.
    ///   - page: The current page.
    /// - Returns: The current publisher with the data.
    static func requestMovieList(_ path: Path, page: Int) -> AnyPublisher<MovieList, Error> {
        guard let url = URL(string: baseURL) else { fatalError("URL_CREATION_ERROR") }
        guard var components = URLComponents(url: url.appendingPathComponent(path.rawValue), resolvingAgainstBaseURL: true) else { fatalError("COMPONENT_CREATION_ERROR")}
        components.queryItems = [
            URLQueryItem(name: "api_key", value: Constants.apiKey),
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "language", value: MovieAPI.createLanguageCode())
        ]
        guard let completeURL = components.url else { fatalError("URL_CREATION_ERROR")}
        let request = URLRequest(url: completeURL)
        return servicesClient.fetch(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    /// Fetch movie details.
    /// - Parameter movieID: This is the unique movie identifier.
    /// - Returns: The current publisher with the data.
    static func requestMovieDetail(_ movieID: Int) -> AnyPublisher<MovieDetailModel, Error> {
        guard let url = URL(string: baseURL) else { fatalError("URL_CREATION_ERROR") }
        guard var components = URLComponents(url: url.appendingPathComponent("\(Path.movie.rawValue)"+"\(movieID)"), resolvingAgainstBaseURL: true) else { fatalError("COMPONENT_CREATION_ERROR") }
        components.queryItems  = [
            URLQueryItem(name: "api_key", value: Constants.apiKey),
            URLQueryItem(name: "language", value: MovieAPI.createLanguageCode())
        ]
        print(components)
        guard let completeURL = components.url else { fatalError("URL_CREATION_ERROR")}
        let request = URLRequest(url: completeURL)
        return servicesClient.fetch(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    /// Fetch movie credits.
    /// - Parameter movieID: This is the unique movie identifier.
    /// - Returns: The current publisher with the data.
    static func requestMovieCredits(_ movieID: Int) -> AnyPublisher<CastList, Error> {
        guard let url = URL(string: baseURL) else { fatalError("URL_CREATION_ERROR") }
        guard var components = URLComponents(url: url.appendingPathComponent("\(Path.movie.rawValue)"+"\(movieID)/credits"), resolvingAgainstBaseURL: true) else { fatalError("COMPONENT_CREATION_ERROR") }
        components.queryItems  = [
            URLQueryItem(name: "api_key", value: Constants.apiKey),
            URLQueryItem(name: "language", value: MovieAPI.createLanguageCode())
        ]
        guard let completeURL = components.url else { fatalError("URL_CREATION_ERROR")}
        let request = URLRequest(url: completeURL)
        return servicesClient.fetch(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    /// Fetch movie videos.
    /// - Parameter movieID: This is the unique movie identifier.
    /// - Returns: The current publisher with the data.
    static func requestMovieVideos(_ movieID: Int) -> AnyPublisher<Videos, Error> {
        guard let url = URL(string: baseURL) else { fatalError("URL_CREATION_ERROR") }
        guard var components = URLComponents(url: url.appendingPathComponent("\(Path.movie.rawValue)"+"\(movieID)/videos"), resolvingAgainstBaseURL: true) else { fatalError("COMPONENT_CREATION_ERROR") }
        components.queryItems  = [
            URLQueryItem(name: "api_key", value: Constants.apiKey),
            URLQueryItem(name: "language", value: MovieAPI.createLanguageCode())
        ]
        guard let completeURL = components.url else { fatalError("URL_CREATION_ERROR")}
        let request = URLRequest(url: completeURL)
        return servicesClient.fetch(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
}
