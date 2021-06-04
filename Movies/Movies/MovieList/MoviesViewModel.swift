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
    var category = Path.popular
    var cancellationToken: AnyCancellable?
    var currentPage = 1
    
    init() {
        self.fetchMovies(category)
    }
    
    func fetchMovies(_ movieType: Path) {
        cancellationToken = MovieAPI.requestMovieList(movieType, page: 1)
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                    self.movies = $0.results
                    self.category = movieType
            })
    }
    func fetchNext() {
        cancellationToken = MovieAPI.requestMovieList(category, page: currentPage)
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
