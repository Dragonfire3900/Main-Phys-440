//
//  logMapTest.swift
//  Tests macOS
//
//  Created by Joel Kelsey on 9/22/22.
//

import XCTest

final class logMapTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testParamMutation() throws {
        let testMap = logMap(firstVal: 10.0)
        
        XCTAssertEqual(testMap.currVal[0], 10.0 as logMap.T)
        XCTAssertEqual(testMap.params["mu"], 0.1 as logMap.T)
        
        testMap.params["mu"] = 2.0
        
        XCTAssertEqual(testMap.params["mu"], 2.0 as logMap.T)
    }
    
    func testIteration() throws {
        var start: logMap.T = 2.0
        let mu: logMap.T = 1.0
        let iterNum: Int = 10
        var count = 0
        
        let testMap = logMap(firstVal: 2.0, mu: 1.0)
        
        for val in testMap.makeIterator(iterNum: iterNum) {
            XCTAssertEqual(start, val[0])
            start = mu * start * (1.0 - start)
            count += 1
        }
        
        XCTAssertEqual(count, iterNum)
    }

    func testIterReset() throws {
        let start: logMap.T = 2.0
        let mu: logMap.T = 1.0
        let iterNum: Int = 10
        
        let testMap = logMap(firstVal: start, mu: mu)
        
        let iter = testMap.makeIterator(iterNum: iterNum, reset: true)
        let initVal = iter.initVal
        
        var test: logMap.T
        
        for res in iter {
            test = res[0] + 1.0
        }
        
        XCTAssertEqual(testMap.currVal, initVal)
    }
    
    func testKeys() throws {
        
    }
}
