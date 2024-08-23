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

import Foundation

/**
 About Exchange Rates
 The provided exchange rates are NOT current and only intended for test and experimentation.
 */
public typealias Currency = Measurement<UnitCurrency>


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
    
//    public init? (country: String) {
//        country_code = country
//        let locale = Locale(identifier: country)
//        let currencySymbol = locale.currency?.identifier
//        super.init(symbol: currencySymbol, converter: UnitCurrency.instantiateConverter(currencySymbol))
//    }
    
    public var currencyCode: String? {
        guard let country_code = country_code else { return nil }
        let locale = Locale(identifier: country_code)
        return locale.currency?.identifier
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
    /**
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


// MARK: - ExchangeRates
// https://open.er-api.com/v6/latest/USD

struct ExchangeRates: Codable {
    let result: String
    let provider, documentation, termsOfUse: String
    let timeLastUpdateUnix: Int
    let timeLastUpdateUTC: String
    let timeNextUpdateUnix: Int
    let timeNextUpdateUTC: String
    let timeEOLUnix: Int
    let baseCode: String
    let rates: [String: Double]

    enum CodingKeys: String, CodingKey {
        case result, provider, documentation
        case termsOfUse = "terms_of_use"
        case timeLastUpdateUnix = "time_last_update_unix"
        case timeLastUpdateUTC = "time_last_update_utc"
        case timeNextUpdateUnix = "time_next_update_unix"
        case timeNextUpdateUTC = "time_next_update_utc"
        case timeEOLUnix = "time_eol_unix"
        case baseCode = "base_code"
        case rates
    }
    
}

// Enum Generator

extension URL {
    static var exchangeRates: URL { URL(string: "https://open.er-api.com/v6/latest/USD")! }
}

extension ExchangeRates {
    struct MetaData: Codable {
        var provider: URL
        var documentation: URL
        var lastUpdate: Date
        var nextUpdate: Date
    }
    
    var metadata: MetaData {
        MetaData(provider: URL(string: self.provider)!,
                 documentation: URL(string: self.documentation)!,
                 lastUpdate: Date(timeIntervalSince1970: TimeInterval(self.timeLastUpdateUTC)!),
                 nextUpdate: Date(timeIntervalSince1970: TimeInterval(self.timeNextUpdateUTC)!))
    }
    
    func generateEnum(limit: Int = 500) -> String {
        var str = "enum ExchangeRate: Double, Codable {\n"
        
        var count = 0
        for (key, value) in rates {
            print("    case \(key.uppercased()) = \(value)", to: &str)
//            str += "    case \(key.uppercased()) = \(value)\n"
            count += 1
            if count >= limit { break }
        }
        print("""
        
            var code: String { String(describing: self) }
            var rate: Double { rawValue }
        }
        """, to: &str)
        return str
     }
}

extension ExchangeRates {
    
    init(from url: URL) throws {
        let data = try Data(contentsOf: url)
        self = try ExchangeRates(from: data)
    }
    
    init(from data: Data) throws {
        let dc = JSONDecoder()
        let json = try dc.decode(ExchangeRates.self, from: data)
        self = json
    }
    
    static var sample: ExchangeRates {
        try! ExchangeRates(from: jsonData)
    }
    
    static var jsonData = """
{"result":"success","provider":"https://www.exchangerate-api.com","documentation":"https://www.exchangerate-api.com/docs/free","terms_of_use":"https://www.exchangerate-api.com/terms","time_last_update_unix":1724025751,"time_last_update_utc":"Mon, 19 Aug 2024 00:02:31 +0000","time_next_update_unix":1724112381,"time_next_update_utc":"Tue, 20 Aug 2024 00:06:21 +0000","time_eol_unix":0,"base_code":"USD","rates":{"USD":1,"AED":3.6725,"AFN":71.016252,"ALL":90.546764,"AMD":388.108035,"ANG":1.79,"AOA":896.224421,"ARS":944,"AUD":1.500276,"AWG":1.79,"AZN":1.700134,"BAM":1.774989,"BBD":2,"BDT":117.540636,"BGN":1.775043,"BHD":0.376,"BIF":2881.348943,"BMD":1,"BND":1.316504,"BOB":6.930177,"BRL":5.472157,"BSD":1,"BTN":83.920117,"BWP":13.400365,"BYN":3.264038,"BZD":2,"CAD":1.368645,"CDF":2850.844721,"CHF":0.867267,"CLP":936.549977,"CNY":7.165629,"COP":4017.47619,"CRC":520.078062,"CUP":24,"CVE":100.06963,"CZK":22.866531,"DJF":177.721,"DKK":6.769635,"DOP":59.828471,"DZD":134.353208,"EGP":48.838355,"ERN":15,"ETB":109.541281,"EUR":0.907539,"FJD":2.234295,"FKP":0.773355,"FOK":6.769766,"GBP":0.773358,"GEL":2.686386,"GGP":0.773355,"GHS":15.611113,"GIP":0.773355,"GMD":70.421657,"GNF":8704.905422,"GTQ":7.750961,"GYD":209.309134,"HKD":7.79508,"HNL":24.831503,"HRK":6.837842,"HTG":131.717583,"HUF":358.428746,"IDR":15688.05663,"ILS":3.677988,"IMP":0.773355,"INR":83.920127,"IQD":1310.696768,"IRR":42069.27132,"ISK":139.106032,"JEP":0.773355,"JMD":157.210066,"JOD":0.709,"JPY":148.042596,"KES":128.979169,"KGS":85.734152,"KHR":4124.246671,"KID":1.500269,"KMF":446.479215,"KRW":1350.003043,"KWD":0.305712,"KYD":0.833333,"KZT":478.947251,"LAK":22023.722412,"LBP":89500,"LKR":298.566193,"LRD":195.260541,"LSL":17.861494,"LYD":4.792865,"MAD":9.772076,"MDL":17.582754,"MGA":4577.467135,"MKD":55.944868,"MMK":2102.108564,"MNT":3378.947165,"MOP":8.028932,"MRU":39.799971,"MUR":46.314541,"MVR":15.421968,"MWK":1737.451325,"MXN":18.63293,"MYR":4.431477,"MZN":63.913789,"NAD":17.861494,"NGN":1589.504939,"NIO":36.850468,"NOK":10.68785,"NPR":134.272187,"NZD":1.652117,"OMR":0.384497,"PAB":1,"PEN":3.742677,"PGK":3.887325,"PHP":57.082917,"PKR":278.486704,"PLN":3.870604,"PYG":7608.243841,"QAR":3.64,"RON":4.526961,"RSD":106.443087,"RUB":89.378323,"RWF":1322.06323,"SAR":3.75,"SBD":8.505192,"SCR":13.518586,"SDG":458.739153,"SEK":10.454472,"SGD":1.316512,"SHP":0.773355,"SLE":22.451424,"SLL":22451.423718,"SOS":571.890189,"SRD":28.893735,"SSP":2683.857048,"STN":22.23467,"SYP":12860.52293,"SZL":17.861494,"THB":34.85934,"TJS":10.605885,"TMT":3.500532,"TND":3.066811,"TOP":2.338029,"TRY":33.706931,"TTD":6.79389,"TVD":1.500269,"TWD":32.092281,"TZS":2702.2802,"UAH":41.227988,"UGX":3724.132235,"UYU":40.421881,"UZS":12707.572003,"VES":36.6848,"VND":25048.492735,"VUV":118.243894,"WST":2.729339,"XAF":595.30562,"XCD":2.7,"XDR":0.748415,"XOF":595.30562,"XPF":108.298273,"YER":250.319587,"ZAR":17.860111,"ZMW":26.375513,"ZWL":13.7902}}
""".data(using: .utf8)!
}
