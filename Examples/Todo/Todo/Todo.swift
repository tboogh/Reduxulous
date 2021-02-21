//
//  Todo.swift
//  TododoMvvm
//
//  Created by Tobias Boogh on 2021-02-06.
//

import Foundation

public struct Todo : Identifiable, Equatable{
    public let id: UUID
    public var name : String
    public var sortOrder : Int
}
