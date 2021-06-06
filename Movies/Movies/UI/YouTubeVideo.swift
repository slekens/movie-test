//
//  YouTubeVideo.swift
//  Movies
//
//  Created by Abraham Abreu on 06/06/21.
//

import Foundation
import SwiftUI
import youtube_ios_player_helper
/// Class to add support for youtube videos.
struct MovieVideo : UIViewRepresentable {
    // MARK: - Properties
    var videoID : String
    // MARK: - Video creation
    func makeUIView(context: Context) -> YTPlayerView {
        let playerView = YTPlayerView()
        playerView.load(withVideoId: videoID)
        return playerView
    }
    func updateUIView(_ uiView: YTPlayerView, context: Context) {}
}
