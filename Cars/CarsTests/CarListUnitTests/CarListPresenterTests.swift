//
//  CarListPresenterTests.swift
//  CarsTests
//
//  Created by Ravi Vora on 26/8/2563 BE.
//  Copyright © 2563 Ravi Vora. All rights reserved.
//

import XCTest
@testable import Cars

class CarListPresenterTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    // MARK: - Tests
    
    func testDisplayFetchedCarsCalledByPresenter() {
        // Given
        let viewControllerSpy = ViewControllerSpy()
        let sut = CarListPresenter(viewController: viewControllerSpy)
        // When
        sut.displayCarList(axCarList: [])
        // Then
        XCTAssert(viewControllerSpy.displayFetchedCarsCalled,
                  "displayCarList() should ask the view controller to display them")
    }
    
    func testPresentFetchedCarsShouldFormatFetchedCarsForDisplay() {
        // Given
        let viewControllerSpy = ViewControllerSpy()
        let sut = CarListPresenter(viewController: viewControllerSpy)
        let cars = [Seeds.Cars.car1]
        // When
        sut.displayCarList(axCarList: cars)
        // Then
        let displayedCars = viewControllerSpy.cars
        
        XCTAssertEqual(displayedCars.count, cars.count,
                       "displayedCars() should ask the view controller to display same amount of cars it receive")
        
        for (_, displayedCar) in displayedCars.enumerated() {
            XCTAssertEqual(displayedCar.title, "Q7 - Greatness starts, when you don't stop.")
        }
    }
}
