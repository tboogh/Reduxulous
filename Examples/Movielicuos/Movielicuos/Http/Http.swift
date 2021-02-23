import Combine
import Foundation

protocol Http {
    func dataTaskPublisher(url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
}

class BaseHttp : Http{
    
    private let session: URLSession
    
    init() {
        session = URLSession(configuration: .default)
    }
    
    func dataTaskPublisher(url: URL) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        return session.dataTaskPublisher(for: url).eraseToAnyPublisher()
    }
}
