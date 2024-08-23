
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

extension Unit {
    public static func literalUnit() -> Self {
        if let f = Self.self as? Dimension.Type {
            return f.init(symbol: "<unit>") as! Self
        }
        return Self(symbol: "")
    }
}

//extension Measurement: ExpressibleByFloatLiteral where UnitType: Unit {
//    public init(floatLiteral value: Double) {
//        self = Measurement(value: value, unit: UnitType.literalUnit())
//    }
//}
//
//extension Measurement: ExpressibleByIntegerLiteral where UnitType: Unit {
//    public init(integerLiteral value: Double) {
//        self = Measurement(value: value, unit: UnitType.literalUnit())
//    }
//}
//
//extension Measurement: ExpressibleByNilLiteral where UnitType: Unit {
//    public init(nilLiteral: ()) {
//        self = Measurement(value: 0, unit: UnitType.literalUnit())
//    }
//}

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
