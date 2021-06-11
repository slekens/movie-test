//
//  ContentView.swift
//  StickyHeader
//
//  Created by Kavsoft on 24/05/20.
//  Copyright © 2020 Kavsoft. All rights reserved.
//

import SwiftUI
import AVKit
/// Movie detail view
struct MovieDetailView : View {
    // MARK: - Propoerties
    var movie: Movie
    @ObservedObject var model = MovieDetailViewModel()
    @State var time = Timer.publish(every: 0.1, on: .current, in: .tracking).autoconnect()
    @State var show = false
    // MARK: - Body View
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
                            VStack(spacing: 10){
                                HStack {
                                    Text("LABEL_RANK")
                                        .font(.subheadline)
                                    PopularityBadge(score: Int(model.movieDetail.voteAverage * 10))
                                    Text("LABEL_TOTAL_VOTES \(model.movieDetail.voteCount)")
                                        .font(.subheadline)
                                }
                                GenreView(genres: model.movieDetail.genres, geometry: geometry)
                                .padding()
                                VStack(alignment: .leading) {
                                    Text(movie.overview)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                VStack(alignment: .leading) {
                                    Text("LABEL_CAST")
                                        .font(.title2)
                                    CastView(castList: model.casList)
                                    if model.videos.count != 0 {
                                        Text("LABEL_VIDEOS")
                                            .font(.title2)
                                        MovieVideo(videoID: model.videos[0].key)
                                            .frame(width: geometry.size.width - 30, height: 280, alignment: .center)
                                            .cornerRadius(25)
                                    }
                                }
                            }
                            .padding(.top)
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
        let sizeDelta: CGFloat = 1.5
        return GeometryReader{ g in
            if let moviePicture = movie.poster {
                AsyncImage(url: MovieAPI.createURL(posterSize: .poster, imageName: moviePicture)) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    case .failure:
                        PlaceholderMovieView()
                    case .empty:
                        VStack(alignment: .center) {
                            LoadingView()
                        }
                        .frame(width: g.size.width, height: g.size.height)
                    @unknown default:
                        EmptyView()
                    }
                }
                    .offset(y: g.frame(in: .global).minY > 0 ? -g.frame(in: .global).minY : 0)
                    .frame(height: g.frame(in: .global).minY > 0 ? UIScreen.main.bounds.height / sizeDelta + g.frame(in: .global).minY  : UIScreen.main.bounds.height / sizeDelta)
                    .cornerRadius(20.0)
            } else {
                PlaceholderMovieView()
                    .offset(y: g.frame(in: .global).minY > 0 ? -g.frame(in: .global).minY : 0)
                    .frame(height: g.frame(in: .global).minY > 0 ? UIScreen.main.bounds.height / sizeDelta + g.frame(in: .global).minY  : UIScreen.main.bounds.height / sizeDelta)
                    .cornerRadius(20.0)
            }
        }
        .frame(height: UIScreen.main.bounds.height / sizeDelta)
    }
}
// MARK: - Preview
#if DEBUG
struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailView(movie: Movie(poster: "avengers", movieID: 12345, title: "Aquaman", overview: "Set before the events of ‘Soul’, 22 refuses to go to Earth, enlisting a gang of 5 new souls in attempt of rebellion. However, 22’s subversive plot leads to a surprising revelation about the meaning of life.", popularity: 800.35, voteCount: 100, voteAverage: 60))
    }
}
#endif
