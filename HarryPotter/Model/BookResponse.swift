//
//  BookResponse.swift
//  HarryPotter
//
//  Created by 권순욱 on 3/24/25.
//

import Foundation

struct BookResponse: Codable {
    let data: [BookData]
    
    struct BookData: Codable {
        let attributes: Book
    }
}
