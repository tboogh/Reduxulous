
import Foundation

protocol Storage {
    func save<Object: Encodable>(key: String, objects: [Object])
    func load<Object: Decodable>(key: String) -> [Object]
}

class FileStorage : Storage{
    fileprivate func pathForKey(_ key: String) -> URL {
        return getDocumentsDirectory().appendingPathComponent(key)
    }
    
    func save<Object: Encodable>(key: String, objects: [Object]) {
        let encodedObjects = try! JSONEncoder().encode(objects)
        let result = String(data: encodedObjects, encoding: .utf8)
        let path = pathForKey(key)
        try! result?.write(to: path, atomically: true, encoding: .utf8)
    }
    
    func load<Object: Decodable>(key: String) -> [Object] {
        let path = getDocumentsDirectory().appendingPathComponent(key)
        let contents = try! String(contentsOf: path)
        let data = contents.data(using: .utf8)!
        
        let result = try! JSONDecoder().decode([Object].self, from: data)
        return result
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        print(paths[0])
        return paths[0]
    }
}
