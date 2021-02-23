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
            for index in indexSet {
                newState.todos.remove(at: index)
            }
            updateSortOrder(todos: &newState.todos)
            break
        case .move(let indices, let newIndex):
            newState.todos.move(fromOffsets: indices, toOffset: newIndex)
            updateSortOrder(todos: &newState.todos)
            break
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
    
    func updateSortOrder(todos: inout [Todo]){
        for index in 0..<todos.count{
            todos[index].sortOrder = index
        }
    }
}
