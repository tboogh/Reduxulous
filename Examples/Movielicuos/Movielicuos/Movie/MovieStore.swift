//
//  MovieStore.swift
//  Movielicuos
//
//  Created by Tobias Boogh on 2021-02-28.
//

import Combine
import Foundation
import Reduxulous

class MovieStore: BaseStore<MovieAction, MovieState>{
    let movieApiService: MovieApiService
    var cancellables = Set<AnyCancellable>()
    
    override init(initialState: MovieState, reducer: Reducer<MovieState, MovieAction>) {
        let config = Movielicuos.Configuration.base
        let http = BaseHttp()
        self.movieApiService = MovieApiService(configuration: config, http: http)
        super.init(initialState: initialState, reducer: reducer)
    }
    
    func updateTopRated(){
        movieApiService.get(page: 1)
            .receive(on: DispatchQueue.main)
            .sink { (completion) in
            
        } receiveValue: { (response) in
            self.dispatch(MovieAction.setTopRated(movies: response.results))
        }
        
        .store(in: &cancellables)

    }
}
