//
//  MovieService.swift
//  Movielicuos
//
//  Created by Tobias Boogh on 2021-02-28.
//

import Combine
import Foundation

protocol MovieService{
    func get(page: Int) -> AnyPublisher<MovieResponse, Error>
}
