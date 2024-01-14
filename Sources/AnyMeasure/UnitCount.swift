//
//  File.swift
//  
//
//  Created by Jason Jobe on 8/7/22.
//

import Foundation

public final class UnitCount: Unit {
    public let subject: String
    public var range: Interval<Double>

    public init(subject: String, symbol: String = "#", range: ClosedRange<Double>) {
        self.subject = subject
        self.range = .init(range)
        super.init(symbol: symbol)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func randomValue(using gen: inout RandomNumberGenerator) -> NSMeasurement {
        let r = range.randomValue(using: &gen)
        return Measurement(value: r, unit: self) as NSMeasurement
    }
    
    public func randomValue() -> NSMeasurement {
        let r = range.randomValue()
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
                return "#\(subject)"
            case .medium:
                return "# of \(subject)"
            case .long:
                return "count of \(subject)"
            @unknown default:
                return "#\(subject)"
        }
    }

    public override func format(
        _ doubleValue: Double,
        style: Formatter.UnitStyle = .short,
        unit: MeasurementFormatter.UnitOptions = .providedUnit
    ) -> String {
        let fmt = NumberFormatter()
        fmt.numberStyle = .decimal
        let vs = fmt.string(for: doubleValue) ?? String(doubleValue)
        switch style {
            case .short:
                return "\(vs)#\(subject)"
            case .medium:
                return "\(vs)#_\(subject)"
            case .long:
                return "\(vs) count of \(subject)"
            @unknown default:
                return "\(vs)#\(subject)"
        }
    }
}

extension Unit {
    @objc
    public class func count(of subj: String, max: Double = 1_000) -> UnitCount {
        return UnitCount(subject: subj, range: 0...max)
    }
}

extension UnitCount {
    @objc
    public override class func count(of subj: String, max: Double = 1_000) -> UnitCount {
        return UnitCount(subject: subj, range: 0...max)
    }
}

public extension Measurement where UnitType == UnitCount {
    
    init(_ value: Double, _ unit: UnitType) {
        self.init(value: value, unit: unit)
    }

    static var zero: Measurement<UnitType> {
        Measurement(value: 0, unit: .count(of: "empty"))
    }
    
    var description: String {
        (self as NSMeasurement).formatted(style: .medium)
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
