//
//  Movie.swift
//  Movielicuos
//
//  Created by Tobias Boogh on 2021-02-28.
//

import Foundation

struct Movie: Codable, Identifiable, Hashable{
    let adult: Bool
    let backdropPath: String
    let genreIds: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Float
    let posterPath: String?
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Float
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

extension Movie{
    public static func mock() -> Movie{
        return Movie(adult: false, backdropPath: "", genreIds: [1], id: 1, originalLanguage: "se", originalTitle: "Title", overview: "Overview", popularity: 0, posterPath: nil, releaseDate: "", title: "Title", video: false, voteAverage: 4.3, voteCount: 123)
    }
}
