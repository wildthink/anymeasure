//
//  File.swift
//  
//
//  Created by Jason Jobe on 8/7/22.
//

import Foundation


//public protocol Countable {
//}
//
//public extension Countable {
//    static var unit: UnitCount { .init(symbol: String(describing: Self.self)) }
//}

public final class UnitCount: Unit {
//    public class var count: UnitCount {
//        return UnitCount(symbol: "count")
//    }
}

extension Unit {
    public class var count: UnitCount {
        return UnitCount(symbol: "count")
    }
}

public extension Measurement where UnitType == UnitCount {
    static var zero: Measurement<UnitType> {
        Measurement(value: 0, unit: .count)
    }
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

postfix operator %

public extension FixedWidthInteger {
    static postfix func %(x: Self) -> Measurement<UnitPercent> {
        .init(Double(x), .percent)
    }
}

public extension BinaryFloatingPoint {
    static postfix func %(x: Self) -> Measurement<UnitPercent> {
        .init(Double(x), .percent)
    }
}
