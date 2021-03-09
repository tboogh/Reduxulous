//
//  MovieResponse.swift
//  Movielicuos
//
//  Created by Tobias Boogh on 2021-02-28.
//

import Foundation

struct MovieResponse : Decodable
{
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results = "results"
        case page = "page"
    }
}
