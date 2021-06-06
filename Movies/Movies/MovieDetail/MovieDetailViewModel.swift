//
//  MovieDetailViewModel.swift
//  Movies
//
//  Created by Abraham Abreu on 02/06/21.
//

import Foundation
import Combine
/// Class viewmodel for the movie detail view.
class MovieDetailViewModel: ObservableObject {
    // MARK: - Properties
    /// The viewmodel object to store all the data about movie detail.
    @Published var movieDetail: MovieDetailModel = MovieDetailModel()
    /// The viewmodel object to store the movie cast information
    @Published var casList = [Cast]()
    /// The viewmodel object to store the videos information.
    @Published var videos = [Video]()
    // MARK: - Tokens
    var cancellationTokenDetail: AnyCancellable?
    var cancellationTokenCasting: AnyCancellable?
    var cancellationTokenVideos: AnyCancellable?
    // MARK: - Remote calls
    /// Function to get the movie details.
    /// - Parameter movieID: The movie id.
    func fetchDetailMovie(movieID: Int) {
        cancellationTokenDetail = MovieAPI.requestMovieDetail(movieID)
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                    self.movieDetail = $0
                  })

    }
    /// Function to get the movie cast or credits.
    /// - Parameter movieID: The movie id.
    func fetchMovieCredits(movieID: Int) {
        cancellationTokenCasting = MovieAPI.requestMovieCredits(movieID)
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                    self.casList = $0.cast
                  })
    }
    /// Function to get the movie videos
    /// - Parameter movieID: The movie id.
    func fetchMovieVideos(movieID: Int) {
        cancellationTokenVideos = MovieAPI.requestMovieVideos(movieID)
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                    self.videos = $0.results
                  })
    }
}
