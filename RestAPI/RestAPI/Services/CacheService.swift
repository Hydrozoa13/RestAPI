//
//  CacheService.swift
//  RestAPI
//
//  Created by Евгений Лойко on 24.10.23.
//

import Foundation
import AlamofireImage

final class CacheService {
    
    private init() {}
    
    static let shared = CacheService()
    
    let imageCache = AutoPurgingImageCache(
        memoryCapacity: 100_000_000,
        preferredMemoryUsageAfterPurge: 60_000_000
    )
}
