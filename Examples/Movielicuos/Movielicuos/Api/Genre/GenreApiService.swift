import Combine
import Foundation

class GenreApiService : ApiService, GenreService{
    typealias ReturnType = [Genre]
    typealias ErrorType = Error
    
    var get: AnyPublisher<[Genre], Error> { getPublisher(url: configuration.getUrl(path: .genre)) }
    
    private let configuration : Configuration
    private let http: Http
    
    init(configuration: Configuration, http: Http){
        self.configuration = configuration
        self.http = http
    }
    
    private func getPublisher(url: URL) -> AnyPublisher<[Genre], Error> {
        print("\(url)")
        let pub =  self.http.dataTaskPublisher(url: url)
        let map = pub.map({ (inputTuple) -> Data in
            if let httpResponse = inputTuple.response as? HTTPURLResponse {
                   print("statusCode: \(httpResponse.statusCode)")
               }
            return inputTuple.data
        })
        let decode = map.decode(type: GenreResponse.self, decoder: JSONDecoder())
            .map{ $0.genres }
        
        return decode.eraseToAnyPublisher()
    }
}
