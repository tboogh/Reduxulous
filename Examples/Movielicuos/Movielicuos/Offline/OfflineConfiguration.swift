//
//  OfflineConfiguration.swift
//  Movielicuos
//
//  Created by Tobias Boogh on 2021-02-25.
//

import Foundation

protocol OfflineData
{
    associatedtype OfflineType
    var lastUpdate: Date {get set}
}
