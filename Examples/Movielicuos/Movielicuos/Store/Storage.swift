
import Foundation

protocol Storage {
    func save<Object: Encodable>(key: String, objects: [Object])
}

class FileStorage : Storage{
    func save<Object: Encodable>(key: String, objects: [Object]) {
        let encodedObjects = try! JSONEncoder().encode(objects)
        let result = String.init(data: encodedObjects, encoding: .utf8)
        let path = getDocumentsDirectory().appendingPathComponent(key)
        try! result?.write(to: path, atomically: true, encoding: .utf8)
    }
    
    func getDocumentsDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        print(paths[0])
        return paths[0]
    }
}
