# AnyMeasure
[![Build Status][build status badge]][build status]

Swift For Any Measure: Simplified

A Quick and Clean Implementation
## Motivation

In addition to the verboseness, the Foundation Unit and Measurement APIs
lack the ability to dynamically declare compound units.
This can make it difficult to perform dimensional analysis
and other multi-step calculations.

The `Ratio` structure allows you to express the ratio
between two units in a type-safe manner
Multiplying a measurement with one unit type by a rate
whose denominator is that same unit type causes those types to cancel out,
resulting in a measurement with the numerator type.

## Requirements

- Swift 4.0+

## Usage

For example, volume over time multiplied by time yields volume:

```swift
    // Ratio of Measures
    typealias FlowRate = Ratio<UnitVolume, UnitDuration>
    let rate: FlowRate = 84760(.cubicFeet, per: .seconds)
    let dailyFlow = (rate * 24(.hours)).converted(to: .megaliters)
        
    // -> ~ 207371ML
```

## Installation

### Swift Package Manager

Add the Rate package to your target dependencies in `Package.swift`:

```swift
import PackageDescription

let package = Package(
  name: "YourProject",
  dependencies: [
    .package(
        url: "https://github.com/wildthink/anymeasure",
        from: "1.0.0"
    ),
  ]
)
```

Then run the `swift build` command to build your project.

## Contact

## License Information

MIT - See LICENSE.md
