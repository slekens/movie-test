//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Abraham Abreu on 02/06/21.
//

import Foundation
import Combine
/// Movies View Model
class MovieViewModel: ObservableObject  {
    
    @Published var movies: [Movie] = []
    var cancellationToken: AnyCancellable?
    var currentPage = 1
    
    init() {
        self.fetchMovies()
    }
    
    func fetchMovies() {
        cancellationToken = MovieAPI.requestMovieList(.popular, page: currentPage)
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                    self.movies += $0.results
                    self.currentPage += 1
            })
    }
}
