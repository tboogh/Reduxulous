//
//  MovieState.swift
//  Movielicuos
//
//  Created by Tobias Boogh on 2021-02-28.
//

import Foundation
import Reduxulous

class MovieState: State, ObservableObject{
    @Published var topRatedMovies: [Movie] = []
    @Published var selectedMovie: Movie? = nil
    @Published var displaySelectedMovie: Bool = false
    
    
}

extension MovieState{
    public static func stub() -> MovieState{
        let state = MovieState()
        state.topRatedMovies = [Movie.mock()]
        return state
    }
}
