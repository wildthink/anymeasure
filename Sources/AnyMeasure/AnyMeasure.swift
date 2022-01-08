import Foundation

public struct AnyMeasure: CustomStringConvertible {
    public var description: String = """
        Author: Jason Jobe
        Copyright: 2021 - See enclosed LICENSE
        Credits:
            //
    """

    public init() {
    }
}


public typealias Mass = Measurement<UnitMass>
public typealias Duration = Measurement<UnitDuration>
public typealias Angle = Measurement<UnitAngle>
public typealias Length = Measurement<UnitLength>
public typealias Distance = Measurement<UnitLength>
public typealias Speed = Measurement<UnitSpeed>

public typealias Velocity = Ratio<UnitLength,UnitDuration>


