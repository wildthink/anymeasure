# AnyMeasure

Swift For Any Measure: Simplified
A clean, Swift interface for `Foundation.Measurement`

Read my post about it [here](https://medium.com/@jasonj_2009/measurements-in-swift-enhanced-simplified-again-7095b4600f58).

#### Requirements: Swift 4.0+

## Motivation

The idea of type-safe numeric values, in other words, `Measurements`
sounds great but, alas, the ergonomics are poor. At least until
now. Wouldn't it be great to do this


```swift
    let m: Mass = 123(.kilograms) + 17(.stones)
    // or let m = Mass(123, .kilograms) + 17(.stones)
    m.converted(to: .pounds) // 509.1688786398349 lb
```

instead of this?

```swift
    let m = Measurement(value: 123, unit: UnitMass.kilograms)
    let m2 = m + Measurement(value: 17, unit: UnitMass.stones)
    print (m2.converted(to: .pounds)) // 509.1688786398349 lb
```

In addition to its verboseness, the Foundation Unit and Measurement
APIs also lack the ability to dynamically declare compound units.
This can make it difficult to perform dimensional analysis
and other multi-step calculations.

The `Ratio` structure allows you to express the ratio
between two units in a type-safe manner
Multiplying a measurement with one unit type by a rate
whose denominator is that same unit type causes those types to cancel out,
resulting in a measurement with the numerator type.

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
- [Medium: Measurements in Swift ](https://medium.com/@jasonj_2009/measurements-in-swift-enhanced-simplified-again-7095b4600f58)
- @JasonJobe17


## License Information

MIT - See LICENSE.md

## Credits
Thanks to
- Flight School: Read Evaluate Press for Rate.swift
    Original Code at https://github.com/Flight-School/Rate
    This functionality is discussed in Chapter 5 of
    [Flight School Guide to Swift Numbers](https://flight.school/books/numbers).
