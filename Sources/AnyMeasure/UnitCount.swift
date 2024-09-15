//
//  File.swift
//  
//
//  Created by Jason Jobe on 8/7/22.
//

import Foundation

public typealias Count = Measurement<UnitCount>


public final class UnitCount: Unit, UnitPresentation {
    public var label: String { "Count" }
    var _range: Interval<Double>
    
    public var range: ClosedRange<Double> {
        _range.range
//        Range(uncheckedBounds: (lower: min, upper: max)))
    }
    
    public init(symbol: String = "#", range: ClosedRange<Double>) {
        self._range = .init(range)
        super.init(symbol: symbol)
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
                return "#\(label)"
            case .medium:
                return "# of \(label)"
            case .long:
                return "count of \(label)"
            @unknown default:
                return "#\(label)"
        }
    }

    public override func format(
        _ value: NSMeasurement,
        style: Formatter.UnitStyle = .short,
        unit: MeasurementFormatter.UnitOptions = .providedUnit
    ) -> String {
        let fmt = NumberFormatter()
        fmt.numberStyle = .decimal
        let vs = fmt.string(for: value.doubleValue) ?? String(value.doubleValue)
        switch style {
            case .short:
                return "\(vs)#\(label)"
            case .medium:
                return "\(vs)#_\(label)"
            case .long:
                return "\(vs) count of \(label)"
            @unknown default:
                return "\(vs)#\(label)"
        }
    }
}

extension Unit {
    @objc
    public class func count(max: Double = 100) -> UnitCount {
        return UnitCount(range: 0...max)
    }
}

extension UnitCount {
    @objc
    public override class func count(max: Double = 100) -> UnitCount {
        return UnitCount(range: 0...max)
    }
}

public extension NSMeasurement {
    static func count(start: Double = 0, max: Double = 100) -> NSMeasurement {
        NSMeasurement(doubleValue: start, unit: .count(max: max))
    }
}

public extension Measurement where UnitType == UnitCount {
    
    init(_ value: Double, _ unit: UnitType) {
        self.init(value: value, unit: unit)
    }

    static var zero: Measurement<UnitType> {
        Measurement(value: 0, unit: .count())
    }
    
    var description: String {
        (self as NSMeasurement).formatted(style: .medium)
    }
}

// MARK: Percent
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
