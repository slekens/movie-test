//
//  AsyncImage.swift
//  Movies
//
//  Created by Abraham Abreu on 03/06/21.
//

import SwiftUI
/// Class to get remote image.
struct AsyncImage<Placeholder: View>: View {
    // MARK: - Properties
    @StateObject private var loader: PosterLoader
    private let placeholder: Placeholder
    private let image: (UIImage) -> Image
    // MARK: - Initialization
    init(
        url: URL,
        @ViewBuilder placeholder: () -> Placeholder,
        @ViewBuilder image: @escaping (UIImage) -> Image = Image.init(uiImage:)
    ) {
        self.placeholder = placeholder()
        self.image = image
        _loader = StateObject(wrappedValue: PosterLoader(url: url, cache: Environment(\.imageCache).wrappedValue))
    }
    // MARK: - Body View
    var body: some View {
        content
            .onAppear(perform: loader.load)
    }
    // MARK: - Private methods
    private var content: some View {
        Group {
            if loader.image != nil {
                image(loader.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } else {
                placeholder
            }
        }
    }
}
