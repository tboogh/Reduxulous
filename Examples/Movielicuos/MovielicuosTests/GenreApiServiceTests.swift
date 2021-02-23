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

class GenreApiServiceSpec : QuickSpec{
    override func spec() {
        describe("get"){
            it("downloads genres from api"){
                let config = Movielicuos.Configuration.base
                let http = BaseHttp()
                let service = GenreApiService(configuration: config, http: http)
                
                var cancellables = Set<AnyCancellable>()
                waitUntil(timeout:.seconds(10)) { done in
                    service.get.sink { completion in
                        done()
                    } receiveValue: { result in
                        print(result)
                    }
                    .store(in: &cancellables)
                }
            }
            
            fit("downloads genres from api and stores offline"){
                let config = Movielicuos.Configuration.base
                let http = BaseHttp()
                let service = GenreApiService(configuration: config, http: http)
                let fileStorage = FileStorage()
                let offlineService = OfflineGenreService(genreService: service, store: fileStorage)
                var cancellables = Set<AnyCancellable>()
                
                waitUntil(timeout:.seconds(10)) { done in
                    offlineService.get.sink { completion in
                        done()
                    } receiveValue: { result in
                        print(result)
                    }
                    .store(in: &cancellables)
                }
            }
        }
    }
}
