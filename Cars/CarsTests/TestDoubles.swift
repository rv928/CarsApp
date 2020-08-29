//
//  TestDoubles.swift
//  CarsTests
//
//  Created by Ravi Vora on 26/8/2563 BE.
//  Copyright © 2563 Ravi Vora. All rights reserved.
//

import Foundation
import UIKit
@testable import Cars

// MARK:- Test doubles

class PresenterSpy: CarListPresenterInterface {
    
    var presentCarsCalled = false
    var cars: [CarListModel.Response.Car]?
    
    func displayCarList(axCarList: [CarListModel.Response.Car]) {
        self.presentCarsCalled = true
        self.cars = axCarList
    }
    
    func showAlertError(error: String?) {}
    func showLoading() {}
    func hideLoading() {}
}

class WorkerSpy: CarListWorkerInterface {
    
    var fetchCarsCalled = false
    var cars: [CarListModel.Response.Car]?
    
    init(cars: CarListModel.Response.CarList?) {
        if cars != nil {
         self.cars = cars?.car!
        }
    }
    
    func fetchCars(request: CarListModel.Request, success: @escaping ([CarListModel.Response.Car]) -> (), fail: @escaping (Int?, String?) -> ()) {
        fetchCarsCalled = true
        if cars != nil {
            success(cars!)
        } else {
            fail(401,"Error")
        }
    }
}

class ViewControllerSpy: CarListView {
    
    var displayFetchedCarsCalled = false
    var cars: [CarListModel.ViewModel] = []
    
    func displayCarList(axCarList: [CarListModel.ViewModel]) {
        displayFetchedCarsCalled = true
        self.cars = axCarList
    }
    
    func showAlertError(error: String?) {}
    func showLoading() {}
    func hideLoading() {}
}

class InteractorSpy: CarListBusinessLogic {
    
    var fetchCarsCalled = false
    
    func fetchCarList(request: CarListModel.Request) {
        fetchCarsCalled = true
    }
    
    func showLoading() {}
}

class TableViewSpy: UITableView {
    
    var reloadDataCalled = false
    
    override func reloadData() {
        reloadDataCalled = true
    }
}
