//
//  File.swift
//  
//
//  Created by Jason Jobe on 1/13/24.
//

import Foundation

public extension NSMeasurement {
    static var zero: NSMeasurement = .init(doubleValue: 0, unit: .init(symbol: ""))
    
    func formatted(
        style: Formatter.UnitStyle = .short,
        unit: MeasurementFormatter.UnitOptions = .providedUnit
    ) -> String {
        self.unit.format(self.doubleValue, style: style, unit: unit)
    }
}

public extension Unit {
    
    @objc func format(
        _ doubleValue: Double,
        style: Formatter.UnitStyle = .short,
        unit: MeasurementFormatter.UnitOptions = .providedUnit
    ) -> String {
        let fmt = MeasurementFormatter()
        fmt.unitStyle = style
        fmt.unitOptions = unit
        fmt.numberFormatter.numberStyle = .decimal
        return fmt.string(for: doubleValue) ?? "\(doubleValue)\(self.symbol)"
    }
}
