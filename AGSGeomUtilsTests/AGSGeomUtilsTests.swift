//
//  AGSGeomUtilsTests.swift
//  AGSGeomUtilsTests
//
//  Created by Nicholas Furness on 6/21/14.
//  Copyright (c) 2014 Esri. All rights reserved.
//

import XCTest
import ArcGIS

class AGSGeomUtilsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testProject() {
        let poly1 = makePolyFromCoords(usaCoords)
        let sr = AGSSpatialReference.webMercatorSpatialReference()
        let poly2 = poly1 >>> sr
        XCTAssert(poly2.spatialReference == sr, "Pass")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
