//
//  TododoReduxListview.swift
//  Tododo
//
//  Created by Tobias Boogh on 2021-02-20.
//

import SwiftUI
import Reduxulous
import Combine

extension String{
    func asBinding(set: @escaping (String) -> Void) -> Binding<String>{
        return Binding(get: {self}, set: { (newV) in
            set(newV)
        })
    }
}

extension Bool{
    func asBinding(set: @escaping (Bool) -> Void) -> Binding<Bool>{
        return Binding(get: {self}, set: { (newV) in
            set(newV)
        })
    }
    
    func asBinding() -> Binding<Bool>{
        return Binding(get: {self}, set: { _ in })
    }
}

struct TodoListview: View {
//    @EnvironmentObject var store : TodoStore
    @EnvironmentObject var store: ReplayStore<TodoAction, TodoState>
    
    var body: some View {
        NavigationView{
            VStack{
                List{
                    if (store.state.displayInput){
                        HStack{
                            TextField("Input", text: store.state.addTodoText.asBinding(set: { (newValue) in
                                store.dispatch(TodoAction.setTodoInput(input: newValue))
                            }))
                            Button(action: {store.dispatch(TodoAction.add(title: store.state.addTodoText))}){
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 25, height: 25, alignment: .center)
                            }
                        }
                    }
                    ForEach(store.state.todos, id:\.id){ todo in
                        Text(todo.name)
                    }
                    .onMove(perform: { indices, newOffset in
                        store.dispatch(TodoAction.move(indices: indices, newIndex: newOffset))
                    })
                    .onDelete(perform: { indexSet in
                        store.dispatch(TodoAction.remove(indexSet: indexSet))
                    })
                    .onTapGesture(perform: {
                        store.dispatch(TodoAction.select)
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
                store.dispatch(TodoAction.displayInput)
            }), trailing: EditButton())
            .navigationBarTitle("Tododo!", displayMode: .large)
            NavigationLink("TodoDetailView", destination: TodoDetailView(), isActive: store.state.displayDetail.asBinding())
        }
    }
    
    func getRange() -> ClosedRange<Float>{
        return 0...Float(store.stateCount)
    }
}

struct TododoReduxListview_Previews: PreviewProvider {
    static var previews: some View {
        let store = ReplayStore(store: TodoStore(initialState: TodoState(todos: [Todo(id: UUID(), name: "Test_1", sortOrder: 0)], displayInput: true, addTodoText: "Test", displayDetail: false)))
        // wrap store for debug
        TodoListview()
            .environmentObject(store)
    }
}
