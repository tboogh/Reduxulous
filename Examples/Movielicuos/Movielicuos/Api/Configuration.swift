
import Foundation

enum ApiPath : String {
    case genre = "/3/genre/movie/list"
}

struct Configuration {
    let apiKey: String
    let serverUrl :String
}

extension Configuration{
    func getUrl(path: ApiPath) -> URL{
        return URL(string: "\(serverUrl)\(path.rawValue)?api_key=\(self.apiKey)")!
    }
}
