//
//  CarListWorker.swift
//  Cars
//
//  Created by Ravi Vora on 25/8/2563 BE.
//  Copyright © 2563 Ravi Vora. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol CarListWorkerInterface {
    func fetchCars(request: CarListModel.Request,
                   success: @escaping ([CarListModel.Response.Car]) -> (),
                   fail: @escaping (_ httpStatus: Int?, _ errorCode: String?) -> ())
}

final class CarListWorker: CarListWorkerInterface {
    
    var service: CarListService!
    
    init(with aService: CarListService) {
        service = aService
    }
    
    func fetchCars(request: CarListModel.Request,
                   success: @escaping ([CarListModel.Response.Car]) -> (),
                   fail: @escaping (_ httpStatus: Int?, _ errorCode: String?) -> ()) {
        
        if Tools.shared.hasConnectivity() == false {
            
            self.getOfflineCarList(success: { (savedList) in
                success(savedList)
            }, fail: { (error) in
                fail(404, error)
            })
        } else {
            service.fetchCarList(request: request, success: { (json) in
                
                self.saveCarList(carList: CarListModel.Response.CarList(json: json),
                                 success: { (savedList) in
                                    success(savedList)
                }) { (error) in
                    fail(404, error)
                }
            }) { (code, error) in
                fail(code,error)
            }
        }
    }
    
    /*
     This method will store car list in core data.
     */
    func saveCarList(carList: CarListModel.Response.CarList,
                     success: @escaping ([CarListModel.Response.Car]) -> (),
                     fail: @escaping (_ error: String?) -> ()) {
        
        DataManager.fetch.saveCarList(carList: carList.car!,
                                      success: { (savedCarList) in
                                        success(savedCarList!)
        }) { (error) in
            fail(error)
        }
    }
    
    /*
     This method will fetch car list from core data.
     */
    func getOfflineCarList(success: @escaping ([CarListModel.Response.Car]) -> (),
                           fail: @escaping (_ error: String?) -> ()) {
        
        DataManager.fetch.getCarList(success: { (savedList) in
            if savedList != nil && savedList?.count != 0 {
                success(savedList!)
            } else {
                fail(NO_DATA)
            }
        }) { (error) in
            fail(error)
        }
    }
}
