/*
 Note that this Ratio type is a rename of the MIT Licensed
 Rate.swift from the Flight School source examples.

 https://github.com/Flight-School/Rate
 */
/*
 Copyright 2018 Read Evaluate Press, LLC
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */
import Foundation

/**
 The Ratio structure allows you to express the ratio between two units in a type-safe manner. Multiplying a measurement with one unit type by a ratio whose denominator is that same unit type causes those types to cancel out, resulting in a measurement with the numerator type.
 
 For example, volume over time multiplied by time yields volume:
 
 let flowRate = Ratio<UnitVolume, UnitDuration>(value: 84760,
 unit: .cubicFeet,
 per: .seconds)
 let oneDay = Measurement<UnitDuration>(value: 24, unit: .hours)
 
 (flowRate * oneDay).converted(to: .megaliters) // 207371ML
 
 A ratio of two related quantities,
 expressed in terms of an amount of numerator unit per single denominator unit.
 */
public struct Ratio<Numerator, Denominator> where Numerator: Unit, Denominator: Unit {
    /// The value of the numerator unit per single denominator unit.
    public var value: Double
    
    /// The numerator unit.
    public var numeratorUnit: Numerator
    
    /// The denominator unit.
    public var denominatorUnit: Denominator
    
    /// The ratio symbol.
    public var symbol: String {
        return "\(self.numeratorUnit.symbol)/\(self.denominatorUnit.symbol)"
    }
    
    /**
     Creates a new ratio from a value,
     and specified numerator and denominator units.
     
     - Parameters:
     - value: The value of the numerator unit per single denominator unit.
     - unit: The numerator unit.
     - per: The denominator unit.
     */
    public init(value: Double, unit numeratorUnit: Numerator, per denominatorUnit: Denominator) {
        self.value = value
        self.numeratorUnit = numeratorUnit
        self.denominatorUnit = denominatorUnit
    }
    
    /**
     Creates a new ratio from specified numerator and denominator measurements.
     
     - Parameters:
     - numerator: The numerator measurement.
     - denominator: The denominator measurement.
     - Precondition: The value of `denominator` must be greater than 0.
     */
    public init(_ numerator: Measurement<Numerator>, per denominator: Measurement<Denominator>) {
        precondition(denominator.value > 0)
        let value = numerator.value / denominator.value
        self.init(value: value, unit: numerator.unit, per: denominator.unit)
    }
    
    /**
     Returns the product of the ratio multiplied by the specified value.
     
     - Parameters:
     - by: The value to multiply the ratio by.
     */
    public func multiplied(by scalar: Double) -> Ratio<Numerator, Denominator> {
        return .init(value: self.value * scalar, unit: self.numeratorUnit, per: self.denominatorUnit)
    }
    
    /**
     Returns the quotient of the ratio divided by the specified value.
     
     - Parameters:
     - by: The value to divide the ratio by.
     */
    public func divided(by scalar: Double) -> Ratio<Numerator, Denominator> {
        return .init(value: self.value / scalar, unit: self.numeratorUnit, per: self.denominatorUnit)
    }
}

extension Ratio where Numerator: Dimension, Denominator: Dimension {
    /**
     Returns the sum of this ratio and the specified ratio.
     
     - Parameters:
     - ratio: The ratio to add to this ratio.
     */
    public func adding(_ ratio: Ratio<Numerator, Denominator>) -> Ratio<Numerator, Denominator> {
        return .init(value: self.value + self.numeratorUnit.converter.value(fromBaseUnitValue: ratio.numeratorUnit.converter.baseUnitValue(fromValue: ratio.value)), unit: self.numeratorUnit, per: self.denominatorUnit)
    }
    
    /**
     Returns the difference between this ratio and the specified ratio.
     
     - Parameters:
     - ratio: The ratio to add to this ratio.
     */
    public func subtracting(_ ratio: Ratio<Numerator, Denominator>) -> Ratio<Numerator, Denominator> {
        return .init(value: self.value - self.numeratorUnit.converter.value(fromBaseUnitValue: ratio.numeratorUnit.converter.baseUnitValue(fromValue: ratio.value)), unit: self.numeratorUnit, per: self.denominatorUnit)
    }
    
    /**
     Returns the product of this ratio multiplied by the specified measurement.
     
     - Parameters:
     - by: The measurement to multiply this ratio by.
     */
    public func multiplied(by measurement: Measurement<Denominator>) -> Measurement<Numerator> {
        return .init(value: Measurement(value: self.value, unit: measurement.unit).converted(to: self.denominatorUnit).value * measurement.value, unit: self.numeratorUnit)
    }
}

extension Ratio: CustomStringConvertible {
    public var description: String {
        return "\(self.value) \(self.symbol)"
    }
}

public func + <T, U>(lhs: Ratio<T,U>, rhs: Ratio<T,U>) -> Ratio<T,U> where T: Dimension, U: Dimension {
    return lhs.adding(rhs)
}

public func - <T, U>(lhs: Ratio<T,U>, rhs: Ratio<T,U>) -> Ratio<T,U> where T: Dimension, U: Dimension {
    return lhs.subtracting(rhs)
}

public func * <T, U>(lhs: Ratio<T,U>, rhs: Double) -> Ratio<T,U> where T: Dimension, U: Dimension {
    return lhs.multiplied(by: rhs)
}

public func / <T, U>(lhs: Ratio<T,U>, rhs: Double) -> Ratio<T,U> where T: Dimension, U: Dimension {
    return lhs.divided(by: rhs)
}

public func * <T, U>(lhs: Ratio<T,U>, rhs: Measurement<U>) -> Measurement<T> where T: Dimension, U: Dimension {
    return lhs.multiplied(by: rhs)
}

public func * <T, U>(lhs: Measurement<U>, rhs: Ratio<T,U>) -> Measurement<T> where T: Dimension, U: Dimension {
    return rhs.multiplied(by: lhs)
}
