//
//  Quantity.swift
//  AnyMeasure
//
//  Created by Jason Jobe on 8/10/24.
//
import Foundation

//public struct Quantity {
//    var measure: NSMeasurement
//    var kind: Kind
//}

extension Quantity {
    public struct Kind: Identifiable, ExpressibleByStringLiteral {
        public var id: String
        
        public init(stringLiteral value: String) {
            id = value
        }
    }
    
    struct Unit: Identifiable, ExpressibleByStringLiteral {
        let id: String
        
        init(name: String) {
            self.id = name
        }
        
        public init(stringLiteral value: String) {
            id = value
        }
    }
}

struct Quantity {
    var value: Double
    var unit: Unit
    var kind: String

    // Conversion logic would go here; for simplicity, assume units are compatible
    func convert(to targetUnit: Unit) -> Quantity {
        // Simplified conversion for demonstration
        return Quantity(value: self.value, unit: targetUnit, kind: self.kind)
    }
}

struct Inventory {
    private var items: [String: Quantity] = [:]

    // Add a single Quantity to the Inventory
    mutating func add(_ quantity: Quantity) {
        let key = inventoryKey(for: quantity)
        if let existingQuantity = items[key] {
            let combinedValue = existingQuantity.value + quantity.convert(to: existingQuantity.unit).value
            items[key] = Quantity(value: combinedValue, unit: existingQuantity.unit, kind: quantity.kind)
        } else {
            items[key] = quantity
        }
    }

    // Add another Inventory to the current Inventory
    mutating func add(_ inventory: Inventory) {
        for quantity in inventory.items.values {
            add(quantity)
        }
    }

    // Helper to generate a key for the inventory dictionary
    private func inventoryKey(for quantity: Quantity) -> String {
        return "\(quantity.kind)_\(quantity.unit)"
    }
}

// Operator overloading

// Adding a Quantity to an Inventory
func +(inventory: Inventory, quantity: Quantity) -> Inventory {
    var newInventory = inventory
    newInventory.add(quantity)
    return newInventory
}

// Adding another Inventory to the current Inventory
func +(lhs: Inventory, rhs: Inventory) -> Inventory {
    var newInventory = lhs
    newInventory.add(rhs)
    return newInventory
}

// Example usage:

func example() {
    let liters = Quantity.Unit(name: "Liters")
    let kilograms = Quantity.Unit(name: "Kilograms")
    
    let water = Quantity(value: 5.0, unit: liters, kind: "Water")
    let milk = Quantity(value: 3.0, unit: liters, kind: "Milk")
    let sugar = Quantity(value: 2.0, unit: kilograms, kind: "Sugar")
    
    var inventory = Inventory()
    inventory = inventory + water
    inventory = inventory + milk
    
    var otherInventory = Inventory()
    otherInventory = otherInventory + sugar
    
    // Combine inventories
    let combinedInventory = inventory + otherInventory
}
