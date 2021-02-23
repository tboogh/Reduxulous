//
//  TodoApp.swift
//  Todo
//
//  Created by Tobias Boogh on 2021-02-20.
//

import SwiftUI
import Reduxulous
@main
struct TodoApp: App {
    let store = ReplayStore(store: TodoStore(initialState: TodoState(todos: [], displayInput: false, addTodoText: "", displayDetail: false)))
    var body: some Scene {
        WindowGroup {
            TodoListview()
                .environmentObject(store)
        }
    }
}
