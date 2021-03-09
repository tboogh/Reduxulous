//
//  MovieDetailMoview.swift
//  Movielicuos
//
//  Created by Tobias Boogh on 2021-02-28.
//

import SwiftUI



struct MovieDetailMovie: View {
    @State var movie : Movie?
    var body: some View {
        Text(movie?.title ?? "No movie")
    }
}

struct MovieDetailMovie_Previews: PreviewProvider {
    static var previews: some View {
        MovieDetailMovie(movie: Movie.mock())
    }
}
