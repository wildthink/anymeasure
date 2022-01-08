import XCTest
@testable import AnyMeasure

final class AnyMeasureTests: XCTestCase {
    
    func testBasicRatio() {
        let flowRate = Ratio<UnitVolume, UnitDuration>(value: 84760,
                                                      unit: .cubicFeet,
                                                      per: .seconds)
        let oneDay = Measurement<UnitDuration>(value: 24, unit: .hours)
        
        let result = (flowRate * oneDay).converted(to: .megaliters) // 207371ML
        XCTAssert(result == Measurement(value: 207371.4020352, unit: .megaliters))
        
        typealias FlowRate = Ratio<UnitVolume, UnitDuration>
        let rate: FlowRate = 84760(.cubicFeet, per: .seconds)
//        let dailyFlow =
//            84760(UnitVolume.cubicFeet, per: UnitDuration.seconds)
//        * 24(.hours)
        
        XCTAssert(result == (rate * 24(.hours)).converted(to: .megaliters))
    }
    
    func testRatio() {
        // AnyMeasure
        let mph: Velocity = 50(.miles, per: .hours)
        let ms = mph.converted(to: .meters, per: .seconds)
        print (mph, ms)
        
        // Apple Builtin
        let s_mph: Speed = 50(.milesPerHour)
        let s_ms = s_mph.converted(to: .metersPerSecond)
        print (s_mph, s_ms)
        
        XCTAssert(mph.value == s_mph.value)
        XCTAssert(ms.value == s_ms.value)
    }
    
    func testMeasurement() throws {
        var m: Mass = .zero
        
        m = 123(.kilograms)
            + 12(.stones)
        print(#function, m, m.converted(to: .pounds))
        XCTAssert(m == 439.16885659359076(.pounds))
    }
    
    func testDuration() {
        let d4: Duration = 34(.hours).converted(to: .minutes)
        XCTAssert(d4 == (34 * 60)(.minutes))
    }
    
    func testCurrency() {
        let usd: Currency = 123.5(.USD)
        let euro = usd.converted(to: .EUR)
        XCTAssert(euro == 99.09887(.EUR))
    }
}
