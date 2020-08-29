//
//  CarListPresenter.swift
//  Cars
//
//  Created by Ravi Vora on 25/8/2563 BE.
//  Copyright © 2563 Ravi Vora. All rights reserved.
//

import Foundation

protocol CarListPresenterInterface {
    func displayCarList(axCarList: [CarListModel.Response.Car])
    func showLoading()
    func hideLoading()
    func showAlertError(error: String?)
}

class CarListPresenter: CarListPresenterInterface {
    
    var carListView: CarListView!
    
    init(viewController: CarListView) {
        self.carListView = viewController
    }
    
    func displayCarList(axCarList: [CarListModel.Response.Car]) {
        
        var displayedCars: [CarListModel.ViewModel] = []
        
        for car in axCarList {
            let displayedCar = CarListModel.ViewModel(with: car)
            displayedCars.append(displayedCar)
        }
        self.carListView.displayCarList(axCarList: displayedCars)
    }
    
    func showLoading() {
        self.carListView.showLoading()
    }
    
    func hideLoading() {
        self.carListView.hideLoading()
    }
    
    func showAlertError(error: String?) {
        self.carListView.showAlertError(error: error)
    }
}
