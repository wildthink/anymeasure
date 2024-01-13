
import Foundation

// MARK: - Ratio Constructor and Conversion Extensions
public extension BinaryFloatingPoint {
    func callAsFunction <N: Dimension, D: Dimension>(
        _ numerator: N, per denominator: D)
    -> Ratio<N,D> {
        Ratio<N, D>(value: Double(self), unit: numerator, per: denominator)
    }
}

public extension BinaryInteger {
    func callAsFunction <N: Dimension, D: Dimension>(
        _ numerator: N, per denominator: D)
    -> Ratio<N,D> {
        Ratio<N, D>(value: Double(self), unit: numerator, per: denominator)
    }
}

public extension Ratio {
    init(_ value: Double, _ numeratorUnit: Numerator, per denominatorUnit: Denominator) {
        self.value = value
        self.numeratorUnit = numeratorUnit
        self.denominatorUnit = denominatorUnit
    }
}

public extension Ratio
where Numerator: Dimension, Denominator: Dimension
{
    func converted(to numerator: Numerator, per denominator: Denominator) -> Ratio {
        let nm = Measurement(value: self.value, unit: numeratorUnit).converted(to: numerator)
        let dm = Measurement(value: 1, unit: denominatorUnit).converted(to: denominator)
        return .init(value: nm.value / dm.value,
                     unit: numerator, per: denominator)
    }

    func callAsFunction(to numerator: Numerator, per denominator: Denominator) -> Ratio {
        self.converted(to: numerator, per: denominator)
    }
}

// MARK: - Measurement Constructor and Conversion Extensions

extension Measurement: ExpressibleByFloatLiteral where UnitType: Dimension {
    public init(floatLiteral value: Double) {
        self = Measurement(value: value, unit: UnitType.baseUnit())
    }
}

extension Measurement: ExpressibleByIntegerLiteral where UnitType: Dimension {
    public init(integerLiteral value: Double) {
        self = Measurement(value: value, unit: UnitType.baseUnit())
    }
}

extension Measurement: ExpressibleByNilLiteral where UnitType: Dimension {
    public init(nilLiteral: ()) {
        self = Measurement(value: 0, unit: UnitType.baseUnit())
    }
}

public extension BinaryFloatingPoint {
    func callAsFunction <U: Unit>(_ units: U) -> Measurement<U> {
        Measurement(value: Double(self), unit: units)
    }
}

public extension BinaryInteger {
    func callAsFunction <U: Unit>(_ units: U) -> Measurement<U> {
        Measurement(value: Double(self), unit: units)
    }
}

public extension Measurement where UnitType: Dimension {
    static var zero: Measurement<UnitType> {
        Measurement(value: 0, unit: UnitType.baseUnit())
    }
    
    func callAsFunction (to units: UnitType) -> Measurement<UnitType> {
        self.converted(to: units)
    }
}

public extension Measurement {
    init (_ value: Double, _ unit: UnitType) {
        self.init(value: value, unit: unit)
    }
}
