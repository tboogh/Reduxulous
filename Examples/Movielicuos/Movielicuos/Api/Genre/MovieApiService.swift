//
//  MovieApiService.swift
//  Movielicuos
//
//  Created by Tobias Boogh on 2021-02-28.
//

import Combine
import Foundation

class MovieApiService : PageApiService, MovieService{
    typealias ReturnType = MovieResponse
    typealias ErrorType = Error
    
    func get(page: Int) -> AnyPublisher<MovieResponse, Error> {
        let url = configuration.getUrl(path: .movieTopRated, query: ["page": "1", "language": "en-US"])
        return getPublisher(url: url)
    }
    
    private let configuration : Configuration
    private let http: Http
    
    init(configuration: Configuration, http: Http){
        self.configuration = configuration
        self.http = http
    }
    
    private func getPublisher(url: URL) -> AnyPublisher<MovieResponse, Error> {
        print("\(url)")
        let pub =  self.http.dataTaskPublisher(url: url)
        let map = pub.map({ (inputTuple) -> Data in
            if let httpResponse = inputTuple.response as? HTTPURLResponse {
                   print("statusCode: \(httpResponse.statusCode)")
               }
            return inputTuple.data
        })
        let decode = map.decode(type: MovieResponse.self, decoder: JSONDecoder())
        
        return decode.eraseToAnyPublisher()
    }
}
