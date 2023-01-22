//
//  File.swift
//  
//
//  Created by Jason Jobe on 8/7/22.
//

import Foundation


public protocol Countable {
}

public extension Countable {
    static var unit: UnitCount { .init(symbol: String(describing: Self.self)) }
}

public final class UnitCount: Unit {
}

/// Percentage Unit
final public class UnitPercent: Unit {
    
    private struct Symbol {
        static let percent      = "%"
    }
    
    /// Percentage Unit
    public class var percent: UnitPercent {
        return UnitPercent(symbol: Symbol.percent)
    }
}

