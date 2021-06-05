//
//  ContentView.swift
//  StickyHeader
//
//  Created by Kavsoft on 24/05/20.
//  Copyright © 2020 Kavsoft. All rights reserved.
//

import SwiftUI

struct MovieDetailView : View {
    var movie: Movie
    @ObservedObject var model = MovieDetailViewModel()
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    @State var show = false
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top, content: {
                ScrollView(.vertical, showsIndicators: false, content: {
                    VStack{
                        HeaderView()
                        VStack(alignment: .leading) {
                            Text(movie.title)
                                .font(.title)
                                .fontWeight(.bold)
                            Text(model.movieDetail.releaseDate.prefix(4))
                                .font(.body)
                            VStack(spacing: 20){
                                PopularityBadge(score: Int(model.movieDetail.popularity / 100))
                                HStack {
                                    let average = String(format: "• Rank: %.1f", model.movieDetail.voteAverage)
                                    Text("\(average)")
                                        .font(.subheadline)
                                    Text("• Total Votes: \(model.movieDetail.voteCount)")
                                        .font(.subheadline)
                                }
                                TagList(genres: model.movieDetail.genres, geometry: geometry)
                                Text(movie.overview)
                            }
                            .padding(.top)
                            CastView(castList: model.casList)
                        }
                        .padding()
                    }
                })
                .onAppear {
                    self.model.fetchDetailMovie(movieID: movie.movieID)
                    self.model.fetchMovieCredits(movieID: movie.movieID)
                    self.model.fetchMovieVideos(movieID: movie.movieID)
                }
            })
            .navigationBarTitle(movie.title, displayMode: .inline)
            .edgesIgnoringSafeArea(.top)
        }
    }
    fileprivate func HeaderView() -> some View {
        let sizeDelta: CGFloat = 2.2
        return GeometryReader{ g in
            if let moviePicture = movie.poster {
                AsyncImage(url: MovieAPI.createURL(posterSize: .poster, imageName: moviePicture),
                           placeholder: {
                            LoadingView()
                                .padding()
                           },
                           image: {
                            Image(uiImage: $0)
                                .resizable()
                           })
                    .offset(y: g.frame(in: .global).minY > 0 ? -g.frame(in: .global).minY : 0)
                    .frame(height: g.frame(in: .global).minY > 0 ? UIScreen.main.bounds.height / sizeDelta + g.frame(in: .global).minY  : UIScreen.main.bounds.height / sizeDelta)
            } else {
                Image(systemName: "movie")
                    .offset(y: g.frame(in: .global).minY > 0 ? -g.frame(in: .global).minY : 0)
                    .frame(height: g.frame(in: .global).minY > 0 ? UIScreen.main.bounds.height / sizeDelta + g.frame(in: .global).minY  : UIScreen.main.bounds.height / sizeDelta)
            }
        }
        .frame(height: UIScreen.main.bounds.height / sizeDelta)
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: Movie(poster: "avengers", movieID: 12345, title: "Aquaman", overview: "Set before the events of ‘Soul’, 22 refuses to go to Earth, enlisting a gang of 5 new souls in attempt of rebellion. However, 22’s subversive plot leads to a surprising revelation about the meaning of life.", popularity: 800.35, voteCount: 100, voteAverage: 60))
    }
}
