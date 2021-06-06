//
//  EnviromentValues+ImageCache.swift
//  Movies
//
//  Created by Abraham Abreu on 03/06/21.
//

import SwiftUI
/// The properties
struct ImageCacheKey: EnvironmentKey {
    // MARK: Properties
    static let defaultValue: ImageCache = TemporaryImageCache()
}
// MARK: - Extension for the cahe values
extension EnvironmentValues {
    var imageCache: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}
