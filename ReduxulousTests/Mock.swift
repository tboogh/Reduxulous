//
//  Mock.swift
//  ReduxulousTests
//
//  Created by Tobias Boogh on 2021-02-20.
//

import Foundation
import Reduxulous

struct MockState : State{
    var value: String = "MockValue"
    var numberValue: Int = 0
}

struct OtherMockState : State{
    var value: Bool = true
}

enum MockAction : Action{
    case test
    case increment
    case decrement
}

enum OtherMockAction: Action{
    case otherTest
}

class MockReducer : Reducer<MockState, MockAction>{
    override func reduce(state: MockState, action: MockAction) -> MockState {
        var newState = state
        switch action {
        case .increment:
            newState.numberValue += 1
            return newState
        case .decrement:
            newState.numberValue -= 1
            return newState
        default:
            return state
        }
    }
}

class OtherReducer : Reducer<OtherMockState, OtherMockAction>{
    
}


class MockStore: BaseStore<MockAction, MockState>{
    convenience init(initialState: MockState){
        self.init(initialState: initialState, reducer: MockReducer())
    }
}

class OtherStore: BaseStore<OtherMockAction, OtherMockState>{
    convenience init(initialState: OtherMockState){
        self.init(initialState: initialState, reducer: OtherReducer())
    }
}
