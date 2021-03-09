//
//  MovieReducer.swift
//  Movielicuos
//
//  Created by Tobias Boogh on 2021-02-28.
//

import Combine
import Foundation
import Reduxulous

class MovieReducer: Reducer<MovieState, MovieAction>{
    override func reduce(state: MovieState, action: MovieAction) -> MovieState {
        var newState = state
        switch action {
        case .setTopRated(movies: let movies):
            newState.topRatedMovies = movies
        case .selectMovie(movie: let movie):
            newState.selectedMovie = movie
            newState.displaySelectedMovie = true
        }
        return newState
    }
}
