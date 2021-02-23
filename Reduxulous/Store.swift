import Foundation

public protocol Store{
    func canHandle(_ action: Action) -> Bool
    func dispatch(_ action: Action) -> Void
}

open class ReplayStore<StoreAction: Action, StoreState: State>: StoreDecorator<StoreAction, StoreState>{
    var isReplaying = false
    var states: [StoreState] = []
    
    @Published public private(set) var stateCount: Int = 0
    @Published public private(set) var selectedStateIndex: Int = 0
    public override init(store: BaseStore<StoreAction, StoreState>) {
        super.init(store: store)
        updateStates(state: store.state)
    }
    
    public override func dispatch(_ action: Action){
        if (isReplaying) {
            return
        }
        super.dispatch(action)
        updateStates(state: super.state)
    }
    
    public func selectState(index: Int){
        if (0..<states.count).contains(index) == false{
            return
        }
        
        super.state = states[index]
        isReplaying = index != (states.count - 1)
        selectedStateIndex = index
    }
    
    private func updateStates(state: StoreState){
        states.append(state)
        stateCount = states.count
        selectedStateIndex = stateCount
    }
}

open class StoreDecorator<StoreAction: Action, StoreState: State>: ObservableObject, Store{
    private let store: BaseStore<StoreAction, StoreState>
    @Published public internal(set) var state: StoreState
    
    public init(store: BaseStore<StoreAction, StoreState>){
        self.store = store
        self.state = self.store.state
    }
    
    public func canHandle(_ action: Action) -> Bool {
        return self.store.canHandle(action)
    }
    
    public func dispatch(_ action: Action) {
        self.store.dispatch(action)
        self.state = self.store.state
    }
    
    
}

open class BaseStore<StoreAction: Action, StoreState: State>: ObservableObject, Store{
    @Published public private(set) var state: StoreState
    let reducer: Reducer<StoreState, StoreAction>
    
    public init(initialState: StoreState, reducer: Reducer<StoreState, StoreAction>){
        self.state = initialState
        self.reducer = reducer
    }
    
    public func canHandle(_ action: Action) -> Bool {
        return action is StoreAction
    }
    
    public func dispatch(_ action: Action) {
        if (canHandle(action)){
            // TODO: Remove this so that a reducer can handle any action if user so chooses
            guard let action = action as? StoreAction else {
                return
            }
            setState(state: reduce(action: action, state: state))
        }
    }
    
    func setState(state: StoreState){
        self.state = state
    }
    
    func reduce(action: StoreAction, state: StoreState) -> StoreState{
        return self.reducer.reduce(state: state, action: action)
    }
}
