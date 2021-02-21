//
//  TododoReduxListview.swift
//  Tododo
//
//  Created by Tobias Boogh on 2021-02-20.
//

import SwiftUI
import Reduxulous
import Combine

struct TodoListview: View {
//    @EnvironmentObject var store : TodoStore
    @EnvironmentObject var store: ReplayStoreDecorator<TodoAction, TodoState>
    @SwiftUI.State private var celsius: Float = 0
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    ForEach(store.state.todos, id:\.id){ todo in
                        Text(todo.name)
                    }
                    .onMove(perform: { indices, newOffset in
                        store.dispatch(TodoAction.move(indices: indices, newIndex: newOffset))
                    })
                    .onDelete(perform: { indexSet in
                        store.dispatch(TodoAction.remove(indexSet: indexSet))
                    })
                }
                HStack{
                    Text("0")
                    Slider(value: Binding<Float>(get: {Float(store.selectedStateIndex)}, set: { newV in
                        store.selectState(index: Int(newV))
                    }), in: getRange(), step: 1.0)
                    Text("\(store.stateCount)")
                }
            }
            .navigationBarItems(leading: Button("Add", action: {
                store.dispatch(TodoAction.add(title: "todo_\(store.state.todos.count)"))
            }), trailing: EditButton())
            .navigationBarTitle("Tododo!", displayMode: .large)
            
        }
    }
    
    func getRange() -> ClosedRange<Float>{
        return 0...Float(store.stateCount)
    }
}

struct TododoReduxListview_Previews: PreviewProvider {
    static var previews: some View {
        let store = ReplayStoreDecorator(store: TodoStore(initialState: TodoState(todos: [Todo(id: UUID(), name: "Test_1", sortOrder: 0)])))
        // wrap store for debug
        TodoListview()
            .environmentObject(store)
    }
}
