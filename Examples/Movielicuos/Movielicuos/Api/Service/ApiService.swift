import Combine

protocol ApiService {
    associatedtype ReturnType
    associatedtype ErrorType : Error
    var get : AnyPublisher<ReturnType, ErrorType> {get}
}
