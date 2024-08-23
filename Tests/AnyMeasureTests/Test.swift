//
//  Test.swift
//  AnyMeasure
//
//  Created by Jason Jobe on 8/18/24.
//

import Testing
import Foundation
@testable import AnyMeasure

struct Test {

    var testDirectory = URL(fileURLWithPath: #filePath)
        .deletingLastPathComponent()
        .deletingLastPathComponent()

    @Test func checkExchangeRates() async throws {
        let ex: ExchangeRates = .sample
        let str = ex.generateEnum(limit: 5)
        print(str)
      }

    @Test func testLoadFromURL() async throws {
        let rates = try ExchangeRates(from: .exchangeRates)
        let furl: URL = testDirectory.appendingPathComponent("exchangeRates")
        let str = rates.generateEnum()
        try str.write(to: furl, atomically: true, encoding: .utf8)
    }
    
    @Test func checkCurrency() async throws {
        let rate: ExchangeRate = .JMD
        print(rate.symbol, rate.rate)
    }
}

enum ExchangeRate: Double, Codable {
    case XCD = 2.7
    case JMD = 157.210066
    case CZK = 22.866531
    case VND = 25048.492735
    case ALL = 90.546764
    
    var symbol: String { String(describing: self) }
    var rate: Double   { rawValue }
}
