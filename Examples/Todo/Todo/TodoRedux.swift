import Foundation
import Reduxulous

public struct TodoState: State{
    var todos: [Todo]
    var displayInput: Bool
    var addTodoText: String
    var displayDetail: Bool
}

public enum TodoAction: Action{
    case displayInput
    case setTodoInput(input: String)
    case add(title: String)
    case remove(indexSet: IndexSet)
    case move(indices: IndexSet, newIndex: Int)
    case select
    case hide
}

public class TodoStore : BaseStore<TodoAction, TodoState>{
    convenience init(initialState: TodoState) {
        self.init(initialState: initialState, reducer: TodoReducer())
    }
}

public class TodoReducer : Reducer<TodoState, TodoAction>{
    fileprivate func extractedFunc(_ newState: inout TodoState) {
        updateSortOrder(todos: &newState.todos)
    }
    
    public override func reduce(state: TodoState, action: TodoAction) -> TodoState {
        var newState = state
        switch action {
        case .add(let title):
            let todo = Todo(id: UUID(), name: title, sortOrder: 0)
            newState.todos.insert(todo, at: 0)
            newState.displayInput = false
            newState.addTodoText = ""
            updateSortOrder(todos: &newState.todos)
            break
        case .remove(let indexSet):
            return remove(state: state, indexSet: indexSet)
        case .move(let indices, let newIndex):
            return move(state: state, indices: indices, index: newIndex)
        case .displayInput:
            newState.displayInput = !newState.displayInput
            break
        case .setTodoInput(let input):
            newState.addTodoText = input
            break
        case .select:
            newState.displayDetail = true
            break
        case .hide:
            newState.displayDetail = false
            break
        }
        
        return newState
    }
}

private extension TodoReducer{
    
    func move(state: TodoState, indices:IndexSet, index: Int) -> TodoState {
        var newState = state
        newState.todos.move(fromOffsets: indices, toOffset: index)
        updateSortOrder(todos: &newState.todos)
        return newState
    }
    
    func remove(state: TodoState, indexSet: IndexSet) -> TodoState {
        var newState = state
        for index in indexSet {
            newState.todos.remove(at: index)
        }
        updateSortOrder(todos: &newState.todos)
        return newState
    }
    
    func updateSortOrder(todos: inout [Todo]){
        for index in 0..<todos.count{
            todos[index].sortOrder = index
        }
    }
}
