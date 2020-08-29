//
//  CarListInteractorTests.swift
//  CarsTests
//
//  Created by Ravi Vora on 26/8/2563 BE.
//  Copyright © 2563 Ravi Vora. All rights reserved.
//

import XCTest
@testable import Cars

class CarListInteractorTests: XCTestCase {

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

    func testFetchCarsCallsWorkerToFetch() {
        // Given
        let cars = CarListModel.Response.CarList.init(cars: Seeds.Cars.all)
        let carWorkerSpy = WorkerSpy(cars: cars)
        let presenterSpy = PresenterSpy()
        
        let sut = CarListInteractor(presenter: presenterSpy, worker: carWorkerSpy)
        let exp = self.expectation(description: "myExpectation")
        
        let request = CarListModel.Request()
        // When
        sut.fetchCarList(request: request)
        
        let queue = DispatchQueue(label: "com.sevenpeakssoftware.Cars")
        let delay: DispatchTimeInterval = .seconds((5))
        queue.asyncAfter(deadline: .now() + delay) {
            XCTAssertTrue(true)
            exp.fulfill()
        }
        self.waitForExpectations(timeout: 30){ [] error in
            print("X: async expectation")
            // Then
            XCTAssert(carWorkerSpy.fetchCarsCalled, "fetchCars() should ask the worker to fetch cars")
        }
    }
    
    func testFetchCarCallsPresenterToFormatFetchedCars() {
        
        // Given
        let cars = CarListModel.Response.CarList.init(cars: Seeds.Cars.all)
        let presenterSpy = PresenterSpy()
        let carWorkerSpy = WorkerSpy(cars: cars)
        
        let sut = CarListInteractor(presenter: presenterSpy, worker: carWorkerSpy)
        let exp = self.expectation(description: "myExpectation")

        let request = CarListModel.Request()
        // When
        sut.fetchCarList(request: request)
        // Then
        
        let queue = DispatchQueue(label: "com.sevenpeakssoftware.Cars")
        let delay: DispatchTimeInterval = .seconds((5))
        queue.asyncAfter(deadline: .now() + delay) {
            XCTAssertTrue(true)
            exp.fulfill()
        }
        self.waitForExpectations(timeout: 30){ [] error in
            print("X: async expectation")
            // Then
            XCTAssertEqual(presenterSpy.cars?.count,
            cars.car?.count, "displayCarList() should ask the presenter to format the same amount of cars it fetched")
        }
    }
}
