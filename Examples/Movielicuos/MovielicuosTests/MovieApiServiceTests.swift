//
//  GenreApiServiceTests.swift
//  MovielicuosTests
//
//  Created by Tobias Boogh on 2021-02-23.
//

import Quick
import Nimble
import XCTest
import Combine
@testable import Movielicuos

class MovieApiServiceSpec : QuickSpec{
    override func spec() {
        describe("get"){
            fit("downloads movies from api"){
                let config = Movielicuos.Configuration.base
                let http = BaseHttp()
                let service = MovieApiService(configuration: config, http: http)
                
                var cancellables = Set<AnyCancellable>()
                waitUntil(timeout:.seconds(10)) { done in
                    
                    service.get(page: 1).sink { completion in
                        done()
                    } receiveValue: { result in
                        expect(result.results).notTo(beEmpty())
                    }
                    .store(in: &cancellables)
                }
            }
        }
    }
}
