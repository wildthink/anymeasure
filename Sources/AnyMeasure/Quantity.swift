//
//  Quantity.swift
//  
//
//  Created by Jason Jobe on 11/20/22.
//

import Foundation

public struct Quantity {
    var measure: NSMeasurement
    var kind: Kind
}

public struct Kind: Identifiable {
    public var id: ID
}
