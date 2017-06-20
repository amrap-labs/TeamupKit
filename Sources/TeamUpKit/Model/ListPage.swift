//
//  ListPage.swift
//  TeamupKit
//
//  Created by Merrick Sapsford on 20/06/2017.
//  Copyright © 2017 Merrick Sapsford. All rights reserved.
//

import Foundation

struct ListPage<T : Codable>: Codable {
    
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
    
    let count: Int
    let nextPageUrl: String?
    let nextPage: Int?
    let previousPageUrl: String?
    let previousPage: Int?
    let currentPage: Int
    let totalPageCount: Int
    
    let results: [T]
}
