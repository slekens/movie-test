//
//  MovieDetailViewModel.swift
//  Movies
//
//  Created by Abraham Abreu on 02/06/21.
//

import Foundation
import Combine

class MovieDetailViewModel: ObservableObject {
    @Published var movieDetail: MovieDetailModel = MovieDetailModel()
    @Published var casList = [Cast]()
    @Published var videos = [Video]()
    var cancellationTokenDetail: AnyCancellable?
    var cancellationTokenCasting: AnyCancellable?
    var cancellationTokenVideos: AnyCancellable?
    
    init() {
    }
    
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
