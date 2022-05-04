# ``AnyMeasure``

## Simplifying Measurement in Swift

## A quick and easy implementation

 [![Jason Jobe](https://miro.medium.com/fit/c/56/56/2*ycjDjALDtNHY1IEcShRjKw.jpeg)](https://medium.com/@jasonj_2009?source=post_page-----30207fd8282c-----------------------------------)

 [Jason Jobe](https://medium.com/@jasonj_2009?source=post_page-----30207fd8282c-----------------------------------)

 [Aug 1, 2021·2 min read](https://betterprogramming.pub/measurement-in-swift-simplified-30207fd8282c?source=post_page-----30207fd8282c-----------------------------------)



![Tape Measures](tape_measures.png)

Image by [William Warby](https://unsplash.com/@wwarby) from [unsplash](https://unsplash.com/photos/WahfNoqbYnM).

I have always liked the idea of using explicit `Measurement` values (magnitude and unit) but I have generally found them cumbersome in actual code.

There are a few solutions out there but I found them somehow unsatisfactory.

So, after some research and reflection, I hit on the following as a desirable syntax that nicely supports autocomplete in Xcode from the available units for any typed `Dimension`.

``` swift
let m: Mass = 123(.kilograms) // => 123.0 kg
let m2: Mass = 123(.kilograms) + 17(.stones) // => 230.95493 kg
m2.converted(to: .pounds) // 509.1688786398349 lb
```

And with a little thought and experimentation, I was able to implement this quite succinctly:

``` swift
public typealias Mass = Measurement<UnitMass>

public extension Double { 
func callAsFunction <U: Dimension>(_ units: U) -> Measurement<U> {
Measurement(value: self, unit: units)
}
}

public extension Int {
func callAsFunction <U: Dimension>(_ units: U) -> Measurement<U> {
Measurement(value: Double(self), unit: units)
}
}
```

Add one small extension for an implicitly unitized zero value:

``` swift
// Example
let z: Mass = .zero

// Using
public extension Measurement where UnitType: Dimension {
static var zero: Measurement<UnitType> {
Measurement(value: 0, unit: UnitType.baseUnit())
}
}
```

By using generics in the `Double` and `Int` extensions, we can easily include any other `Measurement` `Units` with no additional tedious boilerplate code to write.

``` swift
public typealias Duration = Measurement<UnitDuration>
public typealias Angle = Measurement<UnitAngle>
public typealias Length = Measurement<UnitLength>
public typealias Speed = Measurement<UnitSpeed>
```

If you find you want or need any additional units for a particular `Dimension`they are easy enough to add as extension:

``` swift
// As an example
extension UnitDuration {

static let SecondsPerDay: Double = 86_400

static let days = UnitDuration(symbol: "days", 
converter: UnitConverterLinear(coefficient: SecondsPerDay))

static let weeks = UnitDuration(symbol: "weeks",
converter: UnitConverterLinear(coefficient: SecondsPerDay * 7))

static let months = UnitDuration(symbol: "months",
converter: UnitConverterLinear(coefficient: SecondsPerDay * 30))

static let years = UnitDuration(symbol: "years",
converter: UnitConverterLinear(coefficient: SecondsPerDay * 365))
}
```

If this is useful take a look [here](https://gist.github.com/wildthink/4b63ab16250f17d04b85309b5338b479) for the complete code along with some other useful additions.

If you are interested in learning more about Units and Measurements and how to create your own custom ones I recommend the following.

- [Apple: Units and Measurement](https://developer.apple.com/documentation/foundation/units_and_measurement)
- [Unit and Measurement in Swift](https://betterprogramming.pub/unit-and-measurement-in-swift-7c6be4a25586)

## Overview

<!--@START_MENU_TOKEN@-->Text<!--@END_MENU_TOKEN@-->

## Topics

### <!--@START_MENU_TOKEN@-->Group<!--@END_MENU_TOKEN@-->

- <!--@START_MENU_TOKEN@-->``Symbol``<!--@END_MENU_TOKEN@-->
