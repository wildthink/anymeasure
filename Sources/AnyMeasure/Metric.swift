//
//  MetricUnit.swift
//
//
//  Created by Jason Jobe on 11/20/22.
//

import Foundation

public class MetricUnit: Unit {
    var label: String
    var range: Interval<Double>
    
    public init(symbol: String, label: String, range: Interval<Double>) {
        self.label = label
        self.range = range
        super.init(symbol: symbol)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func randomValue(using gen: inout RandomNumberGenerator) -> NSMeasurement {
        let r = range.randomValue(using: &gen)
        return Measurement(value: r, unit: self) as NSMeasurement
    }
    
    public func randomValue() -> NSMeasurement {
        let r = range.randomValue()
        return Measurement(value: r, unit: self) as NSMeasurement
    }
}


public struct Metric {
    var subject: Subject
    var value: Double
    var unit: Unit
    
    var measure: NSMeasurement {
        Measurement(value, unit) as NSMeasurement
    }
}

public extension Measurement {
    func of(_ subject: Metric.Subject) -> Metric {
        Metric(subject: subject, value: self.value, unit: self.unit)
    }
}

public extension Metric {
    init(count: Double, of subj: Subject) {
        subject = subj
        value = count
        unit = UnitCount.count
    }
}

extension Metric: CustomStringConvertible {
    public var description: String {
        "\(measure) of \(subject)"
    }
}

public extension Metric {
    struct Subject: ExpressibleByStringLiteral {
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
}
