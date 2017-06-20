//
//  ListPage.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 20/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

public struct ListPage<T : Codable>: Codable {
    
    enum CodingKeys: String, CodingKey {
        case count
        case nextPageUrl = "next"
        case nextPage = "next_page"
        case previousPageUrl = "previous"
        case previousPage = "previous_page"
        case currentPage = "current_page"
        case totalPageCount = "total_pages"
        case results
    }
    
    public let count: Int
    public let nextPageUrl: URL?
    public let nextPage: Int?
    public let previousPageUrl: URL?
    public let previousPage: Int?
    public let currentPage: Int
    public let totalPageCount: Int
    
    public let results: [T]
}
