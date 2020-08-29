//
//  CarListUITests.swift
//  CarsUITests
//
//  Created by Ravi Vora on 27/8/2563 BE.
//  Copyright © 2563 Ravi Vora. All rights reserved.
//

import XCTest
@testable import Cars

class CarListUITests: XCTestCase {
    
    var customKeywordsUtils: CustomKeywordsUtils? = CustomKeywordsUtils.init()
    let app = XCUIApplication()
    
    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDown() {
        customKeywordsUtils?.deleteOnlyApp()
    }
    
    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testForCarListScreen() {
        
        // Wait for webservice call result
        let exp = self.expectation(description: "myExpectation")
        
        let queue = DispatchQueue(label: "com.sevenpeakssoftware.Cars")
        let delay: DispatchTimeInterval = .seconds((2))
        queue.asyncAfter(deadline: .now() + delay) {
            XCTAssertTrue(true)
            exp.fulfill()
        }
        self.waitForExpectations(timeout: 4){ [] error in
            print("X: async expectation")
            XCTAssertTrue(true)
        }
        
        // Load Car TableView
        let carListTableView = app.tables.matching(identifier: "tableView--carListTableView")
        let carCell = carListTableView.cells.element(matching: .cell, identifier: "CarCell0")
        customKeywordsUtils?.swipeToFindElement(app: app, element: carCell, count: 2)
        
        _ = customKeywordsUtils?.swipeToExpectedCellByText(collectionView:carListTableView.cells["CarCell0"].firstMatch, expectedText: "Q7 - Greatness starts, when you don't stop.", loopCount: 1, swipeSide: .up)
    }
}
