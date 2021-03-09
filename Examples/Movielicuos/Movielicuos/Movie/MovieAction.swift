//
//  MovieAction.swift
//  Movielicuos
//
//  Created by Tobias Boogh on 2021-02-28.
//

import Foundation
import Reduxulous

enum MovieAction: Action{
    case setTopRated(movies: [Movie])
    case selectMovie(movie: Movie)
}
