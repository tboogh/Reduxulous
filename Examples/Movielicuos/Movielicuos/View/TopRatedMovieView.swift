//
//  TopRatedMovieView.swift
//  Movielicuos
//
//  Created by Tobias Boogh on 2021-03-01.
//

import SwiftUI
import Reduxulous

struct TopRatedMovieView: View {
    let state: MovieState
    let selectMovie: (Movie) -> Void
    let showMovie : Bool
    var body: some View {
        ZStack{
            List(state.topRatedMovies){ movie in
                
            }
        }
    }
}

struct TopRatedMovieView_Previews: PreviewProvider {
    static var previews: some View {
        TopRatedMovieView(state: MovieState.stub(), selectMovie: { movie in }, showMovie: false)
    }
}


