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
    /// We store the movie list.
    @Published var movies: [Movie] = []
    /// We store the actual category selected.
    var category = Path.popular
    /// Store the publisher.
    var cancellationToken: AnyCancellable?
    /// Manage the current page from our movies.
    var currentPage = 1
    /// Class constructor
    init() {
        self.fetchMovies(category)
    }
    /// Fetch the movie list by category
    /// - Parameter movieType: The category selected by the user.
    func fetchMovies(_ movieType: Path) {
        currentPage = 1
        cancellationToken = MovieAPI.requestMovieList(movieType, page: currentPage)
            .mapError({ (error) -> Error in
                print(error)
                return error
            })
            .sink(receiveCompletion: { _ in },
                  receiveValue: {
                    self.movies = $0.results
                    self.category = movieType
                    self.currentPage += 1
            })
    }
    /// Fetch the next page from our movie list, with the actual category selected.
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
