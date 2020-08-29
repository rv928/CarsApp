//
//  CarListInteractor.swift
//  Cars
//
//  Created by Ravi Vora on 25/8/2563 BE.
//  Copyright © 2563 Ravi Vora. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol CarListBusinessLogic {
    func fetchCarList(request: CarListModel.Request)
    func showLoading()
}

final class CarListInteractor: CarListBusinessLogic {
    
    var presenter: CarListPresenterInterface!
    var worker: CarListWorkerInterface!
    
    init(presenter: CarListPresenterInterface, worker:
        CarListWorkerInterface = CarListWorker(with: CarListService())) {
        self.presenter = presenter
        self.worker = worker
    }
    
    func fetchCarList(request: CarListModel.Request) {
        
        worker.fetchCars(request: request, success: { (carList) in
            self.presenter.displayCarList(axCarList: carList)
            self.presenter.hideLoading()
        }) { (code, error) in
            self.presenter.hideLoading()
            self.presenter.showAlertError(error: error)
        }
    }
    
    func showLoading() {
        self.presenter.showLoading()
    }
}
