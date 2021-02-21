//
//  ReduxulousTests.swift
//  ReduxulousTests
//
//  Created by Tobias Boogh on 2021-02-20.
//

import XCTest
import Quick
import Nimble
@testable import Reduxulous

class ReduxulousTests: QuickSpec {
    override func spec() {
        describe("ComposedStore"){
            it("composed store get store with type"){
                let mockStore = MockStore(initialState: MockState())
                let otherStore = OtherStore(initialState: OtherMockState())
                
                let composedStore = ComposedStore(stores: [mockStore, otherStore])
                let result: OtherStore? = composedStore.Store()
                
                expect(result).notTo(beNil())
            }
            
        }
        
        describe("ReplayStore"){
            it("StateCount should be 4"){
                let mockStore = MockStore(initialState: MockState())
                let replayStore = ReplayStoreDecorator(store: mockStore)
                replayStore.dispatch(MockAction.increment)
                replayStore.dispatch(MockAction.increment)
                replayStore.dispatch(MockAction.decrement)
                expect(replayStore.stateCount).to(equal(4))
            }
            
            it("selectState 2 should have test value of 2"){
                let mockStore = MockStore(initialState: MockState())
                let replayStore = ReplayStoreDecorator(store: mockStore)
                replayStore.dispatch(MockAction.increment) // state 1
                replayStore.dispatch(MockAction.increment) // state 2
                replayStore.dispatch(MockAction.decrement) // state 3
                
                replayStore.selectState(index: 2)
                expect(replayStore.state.numberValue).to(equal(2))
            }
            
            it("after selectState dispatch should not add new state"){
                let mockStore = MockStore(initialState: MockState())
                let replayStore = ReplayStoreDecorator(store: mockStore)
                replayStore.dispatch(MockAction.increment) // state 1
                replayStore.dispatch(MockAction.increment) // state 2
                
                replayStore.selectState(index: 1)
                
                replayStore.dispatch(MockAction.decrement) // state 3
                
                expect(replayStore.stateCount).to(equal(3))
            }
            
            it("after selectState to last state dispatch should add new state"){
                let mockStore = MockStore(initialState: MockState())
                let replayStore = ReplayStoreDecorator(store: mockStore)
                replayStore.dispatch(MockAction.increment) // state 1
                replayStore.dispatch(MockAction.increment) // state 2
                
                replayStore.selectState(index: 1)
                replayStore.selectState(index: 2)
                replayStore.dispatch(MockAction.decrement) // state 3
                
                expect(replayStore.stateCount).to(equal(4))
            }
        }
    }
}
