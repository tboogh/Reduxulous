import Foundation
import Combine

protocol GenreService {
    var get : AnyPublisher<[Genre], Error> {get}
}
