//
//  File.swift
//  
//
//  Created by Jason Jobe on 1/13/24.
//

import Foundation

public protocol UsableUnit {
    var usage: UnitUsage { get }
}
    
public struct UnitUsage {
    var name: String
    var summary: String?
    
    /// A typical unit name for UnitLength could be
    /// 'Length' or 'Distance', depending on its Usate
    var unitName: String
    var icon: String?
    
    /// The typical or expected value range for this Usage
    var range: ClosedRange<Double>
    
    /// The commonly used Unit in presentation.
    /// For example, for walking, miles or kilometers
    var commonUnit: Unit
    
    var formatter: MeasurementFormatter
}

// MARK: UsableUnitWrapper
public class UsableUnitWrapper<Wrapped: Unit>: Dimension, UsableUnit {
    typealias Wrapped = Wrapped
    public var usage: UnitUsage
    public var wrapped: Wrapped
    
    init(wrap: Wrapped, usage: UnitUsage) {
        self.usage = usage
        self.wrapped = wrap
        let conv = (wrap as? Dimension)?.converter
        ?? UnitConverterLinear(coefficient: 1.0, constant: 0)
        super.init(symbol: wrap.symbol, converter: conv)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public extension UsableUnitWrapper where Wrapped: Dimension {
    static func baseUnit() -> Wrapped {
        Wrapped.baseUnit()
    }
}

public extension Unit {
    func usable(for usage: UnitUsage) -> Dimension {
        UsableUnitWrapper(wrap: self, usage: usage)
    }
}

// MARK: - Presentation
public protocol UnitPresentation {
    var label: String { get }
    var range: ClosedRange<Double> { get }
}

public struct UnitPresentationConfig: UnitPresentation {
    public var value: NSMeasurement
    
    public init(_ value: NSMeasurement) {
        self.value = value
    }
    
    public var label: String {
        if let p = value.unit as? UnitPresentation {
            return p.label
        } else {
            return String(String(describing: type(of: value.unit)))
        }
    }
    
    public var range: ClosedRange<Double> {
        if let p = value.unit as? UnitPresentation {
            return p.range
        } else {
            return 0...1_000
        }
    }
}

public extension NSMeasurement {
    static var zero: NSMeasurement = .init(doubleValue: 0, unit: .init(symbol: ""))
    
    func formatted(
        style: Formatter.UnitStyle = .short,
        unit: MeasurementFormatter.UnitOptions = .providedUnit
    ) -> String {
        self.unit.format(self, style: style, unit: unit)
    }
}

public extension Unit {
    
    @objc func format(
        _ value: NSMeasurement,
        style: Formatter.UnitStyle = .short,
        unit: MeasurementFormatter.UnitOptions = .providedUnit
    ) -> String {
        let fmt = MeasurementFormatter()
        fmt.unitStyle = style
        fmt.unitOptions = unit
        fmt.numberFormatter.numberStyle = .decimal
        return fmt.string(for: value) ?? "\(value.doubleValue)\(self.symbol)"
    }
}
