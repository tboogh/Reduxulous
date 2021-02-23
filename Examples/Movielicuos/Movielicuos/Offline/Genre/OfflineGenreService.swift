
import Foundation
import Combine

class OfflineGenreService : GenreService{
    var get: AnyPublisher<[Genre], Error> {
        getGenres()
    }
    
    let baseService: GenreService
    let store: Storage
    init(genreService: GenreService, store: Storage){
        self.baseService = genreService
        self.store = store
    }
    
    func getGenres() -> AnyPublisher<[Genre], Error> {
        return self.baseService.get
            .map { genres in
                self.store.save(key: "genres", objects: genres)
                return genres
            }
            .eraseToAnyPublisher()
    }
}
