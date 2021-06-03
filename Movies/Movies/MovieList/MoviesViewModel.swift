//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Abraham Abreu on 02/06/21.
//

import Foundation

class MovieViewModel: ObservableObject  {
    
    @Published var movies = MovieList()
    
    init() {
        self.fetchMovies()
    }
    
    func fetchMovies() {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=dcdd37442148f79b3e9aeec690e825a5&page=1&language=es-ES") else {
                   print("Invalid url...")
                   return
               }
               URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error)
                }
                self.movies = try! JSONDecoder().decode(MovieList.self, from: data!)
                print(self.movies)
               }.resume()
    }
    
}
