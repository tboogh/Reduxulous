import Foundation

public struct ComposedStore {
    let stores: [Store]
    
    public func dispatch(_ action: Action){
        for store in stores {
            store.dispatch(action)
        }
    }
    
    func Store<TStore: Store>() -> TStore?{
        return stores.first { (store) -> Bool in
            store is TStore
        } as? TStore
    }
}
