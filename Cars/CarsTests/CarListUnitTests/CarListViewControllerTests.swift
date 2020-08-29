//
//  CarListViewControllerTests.swift
//  CarsTests
//
//  Created by Ravi Vora on 26/8/2563 BE.
//  Copyright © 2563 Ravi Vora. All rights reserved.
//

import XCTest
import UIKit
@testable import Cars

class CarListViewControllerTests: XCTestCase {
    
    var sut: CarListViewController!
    var delegate: UITableViewDelegate!
    var interactorSpy = InteractorSpy()
    
    override func setUp() {
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CarListViewController") as? CarListViewController
        sut.beginAppearanceTransition(true, animated: false)
        sut.endAppearanceTransition()
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
    
    func testShouldDisplayFetchedCars() {
        
        // Given
        let tableViewSpy = TableViewSpy()
        sut.carListTableView = tableViewSpy
        
        let viewModels: [CarListModel.ViewModel] = []
        
        let exp = self.expectation(description: "myExpectation")
        // When
        sut.displayCarList(axCarList: viewModels)
        
        let queue = DispatchQueue(label: "com.sevenpeakssoftware.Cars")
        let delay: DispatchTimeInterval = .seconds((10))
        queue.asyncAfter(deadline: .now() + delay) {
            XCTAssertTrue(true)
            exp.fulfill()
        }
        self.waitForExpectations(timeout: 30){ [] error in
            print("X: async expectation")
            // Then
            XCTAssert(tableViewSpy.reloadDataCalled, "Displaying fetched cars should reload the table view")
        }
    }
    
    func testNumberOfRowsInAnySectionShouldEqualNumberOfCarsToDisplay() {
        // Given
        let tableViewSpy = TableViewSpy()
        sut.carListTableView = tableViewSpy
        
        var viewModels: [CarListModel.ViewModel] = []
        
        sut.displayCarList(axCarList: viewModels)
        
        for _ in 0...8 {
            let ObjCar: CarListModel.Response.Car = CarListModel.Response.Car(119302, "Q7 - Greatness starts, when you don't stop.", "The Audi Q7 is masculine, yet exudes lightness. Inside, it offers comfort at the highest level. With even more space for your imagination. The 3.0 TDI engine accelerates this powerhouse as a five-seater starting at an impressive 6.3 seconds from 0 to 100 kmh.", "29.11.2017 15:12", "https://www.apphusetreach.no//sites//default//files//audi_q7.jpg")
            let displayedCar = CarListModel.ViewModel(with: ObjCar)
            viewModels.append(displayedCar)
        }
        let exp = self.expectation(description: "myExpectation")
        
        let queue = DispatchQueue(label: "com.sevenpeakssoftware.Cars")
        let delay: DispatchTimeInterval = .seconds((10))
        queue.asyncAfter(deadline: .now() + delay) {
            XCTAssertTrue(true)
            exp.fulfill()
        }
        self.waitForExpectations(timeout: 30){ [] error in
            print("X: async expectation")
            // When
            let numberOfRows = self.sut.tableView(self.sut.carListTableView, numberOfRowsInSection: 1)
            // Then
            XCTAssertEqual(numberOfRows, viewModels.count,"The number of tableView rows should equal the number of cars to display")
        }
    }
}
