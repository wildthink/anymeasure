//
//  Currency.swift
//
//  Created on 2/5/18.
//
// About Exchange Rates
// https://www.exchangerate-api.com
//
// https://openexchangerates.org/api/latest.json?app_id=ec347ebded80471986884a250272d7d7
// disclaimer: "Usage subject to terms: https://openexchangerates.org/terms",
// license: "https://openexchangerates.org/license",
// timestamp: 1517828400,
// base: "USD",
/**
 About Exchange Rates
 The provided exchange rates are NOT current and only intended for test and experimentation.
 
 Exchange Rates provided by:
 https://www.exchangerate-api.com
 
 https://openexchangerates.org/api/latest.json?app_id=ec347ebded80471986884a250272d7d7
 disclaimer: "Usage subject to terms: https://openexchangerates.org/terms",
 license: "https://openexchangerates.org/license",
 timestamp: 1517828400,
 base: "USD",

 IMPORTANT NOTICE:
 If you are a business user, please note that in particular, we will not be liable for:
 
 - loss of profits, sales, business, or revenue;
 - business interruption;
 - loss of anticipated savings;
 - loss of business opportunity, goodwill or reputation; or
 - any indirect or consequential loss or damage.
 
 If you are a consumer user, please note that we only provide this Echange Rate data
 for private use. You agree not to use this data for any commercial or business
 purposes, and we have no liability to you for any loss of profit, loss of business,
 business interruption, or loss of business opportunity.
 */
import Foundation

public typealias Currency = Measurement<UnitCurrency>

open class CurrencyConverter: UnitConverterLinear {
    
    //    BIG List Below
    //    static let exchange_rates: [String: Double] = [
    //        "USD": 1,
    //        "EUR": 0.80242
    //    ]
    public var symbol: String
    
    public init (_ symbol: String) {
        self.symbol = symbol
        super.init(coefficient: 1.0, constant: 0)
    }
    
    override init(coefficient: Double, constant: Double) {
        symbol = UnitCurrency.Local.currencyCode ?? "CREDIT"
        super.init(coefficient: coefficient, constant: constant)
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override
    func baseUnitValue(fromValue value: Double) -> Double {
        let scale = CurrencyConverter.exchange_rates[symbol] ?? 1.0
        return value / scale
    }
    public override
    func value(fromBaseUnitValue baseUnitValue: Double) -> Double {
        let scale = CurrencyConverter.exchange_rates[symbol] ?? 1.0
        return baseUnitValue * scale
    }
}

public final class UnitCurrency: Dimension, Codable {
    
    public static var instantiateConverter: (String) -> CurrencyConverter
    = { symbol in CurrencyConverter(symbol) }
    
    var country_code: String?
    
    public init (symbol: String) {
        super.init(symbol: symbol, converter: UnitCurrency.instantiateConverter(symbol))
    }
    
    public init (country: String) {
        country_code = country
        let locale = Locale(identifier: country)
        let currencySymbol = locale.currencyCode!
        super.init(symbol: currencySymbol, converter: UnitCurrency.instantiateConverter(currencySymbol))
    }
    
    public var currencyCode: String? {
        guard let country_code = country_code else { return nil }
        let locale = Locale(identifier: country_code)
        return locale.currencyCode
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public required init(from decoder: Decoder) throws {
        let sym = try decoder.singleValueContainer().decode(String.self)
        super.init(symbol: sym, converter: CurrencyConverter(sym))
    }
    
    public override class func baseUnit() -> UnitCurrency {
        return UnitCurrency.USD
    }
}

/// Example UnitCurrency Extension
/// 
extension UnitCurrency {
    
    public static var Local = UnitCurrency.USD
    
    public static let USD = UnitCurrency(symbol: "USD")
    public static let EUR = UnitCurrency(symbol: "EUR")
}

extension CurrencyConverter {
    /*
     {
     "disclaimer": "Usage subject to terms: https://openexchangerates.org/terms",
     "license": "https://openexchangerates.org/license",
     "timestamp": 1517828400,
     "base": "USD",
     */
    public static let exchange_rates: [String: Double] = [
        "AED": 3.672896,
        "AFN": 69.5275,
        "ALL": 106.93,
        "AMD": 480.835755,
        "ANG": 1.789837,
        "AOA": 207.1,
        "ARS": 19.4605,
        "AUD": 1.259846,
        "AWG": 1.791248,
        "AZN": 1.689,
        "BAM": 1.56955,
        "BBD": 2,
        "BDT": 83.3,
        "BGN": 1.569405,
        "BHD": 0.376979,
        "BIF": 1766.600063,
        "BMD": 1,
        "BND": 1.316602,
        "BOB": 6.928668,
        "BRL": 3.216205,
        "BSD": 1,
        "BTC": 0.00012992225,
        "BTN": 64.215523,
        "BWP": 9.609254,
        "BYN": 1.980896,
        "BZD": 2.015493,
        "CAD": 1.24191,
        "CDF": 1626.123744,
        "CHF": 0.930377,
        "CLF": 0.0227,
        "CLP": 602.8,
        "CNH": 6.294975,
        "CNY": 6.2919,
        "COP": 2801.65,
        "CRC": 573.178269,
        "CUC": 1,
        "CUP": 25.5,
        "CVE": 88.875,
        "CZK": 20.225448,
        "DJF": 178.57,
        "DKK": 5.972443,
        "DOP": 48.965426,
        "DZD": 113.26,
        "EGP": 17.67,
        "ERN": 15.012933,
        "ETB": 27.485406,
        "EUR": 0.80242,
        "FJD": 2.010101,
        "FKP": 0.708772,
        "GBP": 0.708772,
        "GEL": 2.461374,
        "GGP": 0.708772,
        "GHS": 4.497175,
        "GIP": 0.708772,
        "GMD": 47.45,
        "GNF": 9051.25,
        "GTQ": 7.377334,
        "GYD": 208.05068,
        "HKD": 7.82035,
        "HNL": 23.717273,
        "HRK": 5.9651,
        "HTG": 64.207012,
        "HUF": 248.6415,
        "IDR": 13499.189516,
        "ILS": 3.437212,
        "IMP": 0.708772,
        "INR": 64.0505,
        "IQD": 1196.620696,
        "IRR": 36955.667175,
        "ISK": 100.3095,
        "JEP": 0.708772,
        "JMD": 124.719492,
        "JOD": 0.709001,
        "JPY": 109.851,
        "KES": 101.61,
        "KGS": 68.458527,
        "KHR": 4056.316667,
        "KMF": 395.645578,
        "KPW": 900,
        "KRW": 1086.6025,
        "KWD": 0.2996,
        "KYD": 0.835598,
        "KZT": 323.02143,
        "LAK": 8327.55,
        "LBP": 1523.559328,
        "LKR": 154.641346,
        "LRD": 121.729884,
        "LSL": 12.014852,
        "LYD": 1.331997,
        "MAD": 9.1409,
        "MDL": 16.621056,
        "MGA": 3238.3,
        "MKD": 49.333596,
        "MMK": 1333.460206,
        "MNT": 2413.946696,
        "MOP": 8.076477,
        "MRO": 355.5,
        "MRU": 35.28,
        "MUR": 32.2515,
        "MVR": 15.400251,
        "MWK": 725.5,
        "MXN": 18.572086,
        "MYR": 3.900538,
        "MZN": 60.835,
        "NAD": 12.015,
        "NGN": 361.176434,
        "NIO": 31.197559,
        "NOK": 7.709894,
        "NPR": 102.779136,
        "NZD": 1.367848,
        "OMR": 0.384995,
        "PAB": 1,
        "PEN": 3.218062,
        "PGK": 3.241655,
        "PHP": 51.4965,
        "PKR": 111.064759,
        "PLN": 3.335905,
        "PYG": 5666.727124,
        "QAR": 3.6509,
        "RON": 3.718531,
        "RSD": 95.215,
        "RUB": 56.59685,
        "RWF": 865.490959,
        "SAR": 3.7514,
        "SBD": 7.746596,
        "SCR": 13.439854,
        "SDG": 12.8163,
        "SEK": 7.885755,
        "SGD": 1.316751,
        "SHP": 0.708772,
        "SLL": 7654.857772,
        "SOS": 581.015827,
        "SRD": 7.468,
        "SSP": 130.2634,
        "STD": 19688.9704,
        "STN": 19.8,
        "SVC": 8.774246,
        "SYP": 514.96999,
        "SZL": 12.012251,
        "THB": 31.522,
        "TJS": 8.849188,
        "TMT": 3.509974,
        "TND": 2.3772,
        "TOP": 2.20125,
        "TRY": 3.765322,
        "TTD": 6.78137,
        "TWD": 29.32551,
        "TZS": 2250.55,
        "UAH": 27.931043,
        "UGX": 3637.183069,
        "USD": 1,
        "UYU": 28.417907,
        "UZS": 8197.8,
        "VEF": 9.985022,
        "VND": 22708.179309,
        "VUV": 103.706004,
        "WST": 2.488433,
        "XAF": 526.352996,
        "XAG": 0.05920671,
        "XAU": 0.00074812,
        "XCD": 2.70255,
        "XDR": 0.685999,
        "XOF": 526.352996,
        "XPD": 0.00096181,
        "XPF": 95.754173,
        "XPT": 0.00100453,
        "YER": 250.287761,
        "ZAR": 12.04362,
        "ZMW": 9.876778,
        "ZWL": 322.355011
    ]
}

