//
//  Duration.swift
//  
//
//  Created by Jason Jobe on 1/8/22.
//

import Foundation

/// These Calendar convenience UnitDurations are not exact.
/// Rather they are provided to present a relative scale for
/// ratio comaprisons.
public extension UnitDuration {
    
    static let SecondsPerDay: Double = 86_400
    
//    static let minutes = UnitDuration(symbol: "minutes", converter: UnitConverterLinear(coefficient: 60))
//
//    static let hours = UnitDuration(symbol: "hours", converter: UnitConverterLinear(coefficient: (3600))

    static let days = UnitDuration(symbol: "days", converter: UnitConverterLinear(coefficient: SecondsPerDay))
    
    static let weeks = UnitDuration(symbol: "weeks", converter: UnitConverterLinear(coefficient: SecondsPerDay * 7))
    
    static let months = UnitDuration(symbol: "months", converter: UnitConverterLinear(coefficient: SecondsPerDay * 30.4))
    
    static let years = UnitDuration(symbol: "years", converter: UnitConverterLinear(coefficient: SecondsPerDay * 365.25))
}

public extension Duration {
    func `in`(_ unit: UnitDuration) -> Double {
        unit.converter.value(fromBaseUnitValue: .init(self.components.seconds))
    }
}
