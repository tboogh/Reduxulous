//
//  IoC+Configuration.swift
//  Movielicuos
//
//  Created by Tobias Boogh on 2021-02-23.
//

import Foundation

extension Configuration{
    static var base : Configuration {
        return Configuration(apiKey: "9cfc4b88b8988ec5dcba610039770a91", serverUrl: "https://api.themoviedb.org")
    }
}
