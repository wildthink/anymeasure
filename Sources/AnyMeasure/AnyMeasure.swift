import Foundation

///
/// 
public struct AnyMeasure: CustomStringConvertible {
    public var description: String = """
        Author: Jason Jobe
        Copyright: 2021 - See enclosed LICENSE
        Credits:
            https://github.com/Flight-School/Rate
    """

    public init() {
    }
}

/// Units of measure for mass (aka "weight")
public typealias Mass = Measurement<UnitMass>

/// Units of measure for time duration
public typealias Duration = Measurement<UnitDuration>

/// Units of measure for planar angle and rotation.
public typealias Angle = Measurement<UnitAngle>

/// Units of measure for length
public typealias Length = Measurement<UnitLength>

/// Units of measure for length - convenience alias
public typealias Distance = Measurement<UnitLength>

/// Units of measure using Apple's UnitSpeed
public typealias Speed = Measurement<UnitSpeed>

/// Units of measure of velocity (aka Speed) as length/duration
public typealias Velocity = Ratio<UnitLength,UnitDuration>


