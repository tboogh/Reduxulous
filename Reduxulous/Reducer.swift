import Foundation

open class Reducer<TState: State, TAction: Action>{
    public init(){
        
    }
    
    open func reduce(state: TState, action: TAction) -> TState{
        return state
    }
}
