//
//  MetricUnit.swift
//
//
//  Created by Jason Jobe on 11/20/22.
//

import Foundation

public class Metric: Unit, UnitPresentation {
    public var label: String { subject.name }
    public var range: ClosedRange<Double> { _range.range }

    public private(set) var subject: Subject
    var _range: Interval<Double>
    var units: Unit
    // cadance, frequeny, recurs
//    var cycle: TimeFrame
    
    public init(
        _ subject: Subject,
        units: Unit,
//        cycle: TimeFrame = .zero,
        range: Interval<Double>
    ) {
        self.subject = subject
        self._range = range
        self.units = units
//        self.cycle = cycle
        super.init(symbol: units.symbol)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    public func randomValue(using gen: inout RandomNumberGenerator) -> NSMeasurement {
        let r = _range.randomValue(using: &gen)
        return Measurement(value: r, unit: self) as NSMeasurement
    }
    
    public func randomValue() -> NSMeasurement {
        let r = _range.randomValue()
        return Measurement(value: r, unit: self) as NSMeasurement
    }
    
    public override var description: String {
        unitString(style: .short)
    }
    
    public func unitString(
        style: Formatter.UnitStyle = .short,
        unit: MeasurementFormatter.UnitOptions = .providedUnit
    ) -> String {
        switch style {
            case .short:
                return "\(label)_\(units.symbol)"
            case .medium:
                return "\(label) in \(units.symbol)"
            case .long:
                return "\(label) in \(units.symbol)"
            @unknown default:
                return "\(label)_\(units.symbol)"
        }
    }
    
    public override func format(
        _ value: NSMeasurement,
        style: Formatter.UnitStyle = .short,
        unit: MeasurementFormatter.UnitOptions = .providedUnit
    ) -> String {
        let ms = units.format(value)
        
        switch style {
            case .short:
                return "\(label)(\(ms))"
            case .medium:
                return "\(label) in \(ms)"
            case .long:
                return "\(label) in \(ms)"
            @unknown default:
                return "\(label)_\(units.symbol)"
        }
    }
}

extension Metric {
    public class
    func metric(_ label: Subject, units: Unit, range: Interval<Double>) -> Metric {
        return Metric(label, units: units, range: range)
    }
    
    public class
    func metric(count: Subject, range: Interval<Double>) -> Metric {
        return Metric(count, units: .count(), range: range)
    }
    
    public class
    func metric(count: Subject, range: ClosedRange<Int>) -> Metric {
        return Metric(count, units: .count(), range: .init(range))
    }
}

public extension Measurement where UnitType == Metric {
    
    init(_ value: Double, _ unit: UnitType) {
        self.init(value: value, unit: unit)
    }
    
    var description: String {
        (self as NSMeasurement).formatted(style: .medium)
    }
}

public struct Subject: ExpressibleByStringLiteral, Codable, Equatable, Hashable {
    public static func named(_ name: String) -> Self {
        .init(name)
    }
    
    public let name: String
    
    public init(_ value: String) {
        name = value
    }
    
    public init(stringLiteral value: String) {
        name = value
    }
}
