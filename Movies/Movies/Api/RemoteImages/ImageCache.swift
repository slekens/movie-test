//
//  ImageCache.swift
//  Movies
//
//  Created by Abraham Abreu on 03/06/21.
//

import Foundation
import UIKit
/// Protocol to the cache
protocol ImageCache {
    subscript(_ url: URL) -> UIImage? { get set }
}
/// The cache configuration
struct TemporaryImageCache: ImageCache {
    // MARK: Properties
    private let cache: NSCache<NSURL, UIImage> = {
        let cache = NSCache<NSURL, UIImage>()
        cache.countLimit = 100
        cache.totalCostLimit = 1024 * 1024 * 100 // 100 MB
        return cache
    }()
    subscript(_ key: URL) -> UIImage? {
        get { cache.object(forKey: key as NSURL) }
        set { newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as NSURL) }
    }
}
