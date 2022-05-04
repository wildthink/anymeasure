#  Measurements in Swift: Enhanced & Simplified Again


![Drafting Tools](fleur-dQf7RZhMOJU-unsplash.jpg)

Photo by [Fleur](https://unsplash.com/@yer_a_wizard?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText) on [Unsplash](https://unsplash.com/s/photos/measures?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)

Why can't I just do this? With Xcode autocomplete helping us along?

```swift
let v: Velocity = 55(.kilometers, per: .hours)
print(v * 2 * 2(.hours)) //  -> 220 km
```

Turns out you can! Just add this [Package](https://github.com/wildthink/anymeasure) to your project and start coding.

If you want a bit of the backstory and a few more details then read on.

If you haven't yet read [Measurement in Swift: Simplified](https://medium.com/@jasonj_2009/measurement-in-swift-simplified-30207fd8282c) , it's only 2 minutes and, as an earlier work, sets the stage for improvements and updates that follow herein.

Apparently, I have a character flaw that makes it difficult to be satisfied with less than an elegant solution. One that not only enables me to write clearly and succinctly but also scales from a specific to a more general solution.

Given the ease of supporting simple Measurements (as previously explained) I really wanted to extend this pattern to Compound Unit Measurements or at least to the more common `Ratio`. Every time I started in on creating a collection of new Unit combinations I became dissatisfied with the repetitiveness in creating new ones. It wasn't really a lot of code but enough to clutter the call site and aggravate me enough to search for a solution. So after more thought and more than a bit of aggravated wrangling with generics, I worked it out; it turns out you can, with the smallest additions do this. Of course, no sooner than I worked out my own solution, I found `Rate.swift` at a cleaner one. So I used it, with only some small extensions following the pattern I used for the standard `Measurements`.

The trick is to create a generic struct using the standard Measurement `Unit`. Add in methods for `addition`, `subtraction`, and `multiplication` along with the appropriately overloaded operators and you are off to the races.

```swift
public struct Ratio<Numerator, Denominator>
where Numerator: Unit, Denominator: Unit {
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
}
```

And along with `typealias` and the judicious, if not clever, use of `callAsFunction` to enable the `2(.hours)`  syntax we get to use all of the `Foundation` Measurement Units out-of-the-box.

```swift
typealias Velocity = Measurement<Ratio<UnitLength, UnitDuration>>

public extension BinaryFloatingPoint {
    func callAsFunction <N: Dimension, D: Dimension>(
        _ numerator: N, per denominator: D)
    -> Ratio<N,D> {
        Ratio<N, D>(value: Double(self), unit: numerator, per: denominator)
    }
}
...
```

There really isn't much more than that. It's pretty much an rinse-and-repeat for a few more data types. Refer to the GitHub project for the full source and a package you can include in your projects.

I have learned a lot from the many, many contributors out there. To them, I say "Thank you".

For you, the reader, I look forward to your feedback and may you continue to be curious and engaged.

#### Credits & Resources

- The full package is available at [AnyMeasure.git](https://github.com/wildthink/anymeasure).
- [Measurement in Swift: Simplified](https://medium.com/@jasonj_2009/measurement-in-swift-simplified-30207fd8282c)
- Thanks to [Flight School Rate.swift](https://github.com/Flight-School/Rate)

