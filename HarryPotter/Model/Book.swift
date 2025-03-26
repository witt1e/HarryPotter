//
//  Book.swift
//  HarryPotter
//
//  Created by 권순욱 on 3/24/25.
//

import Foundation

struct Book: Codable {
    let title: String
    let author: String
    let pages: Int
    let releaseDate: String
    let dedication: String
    let summary: String
    let wiki: String
    let chapters: [Chapter]
    
    enum CodingKeys: String, CodingKey {
        case title, author, pages
        case releaseDate = "release_date"
        case dedication, summary, wiki, chapters
    }
    
    struct Chapter: Codable {
        let title: String
    }
}
