//
//  CarListService.swift
//  Cars
//
//  Created by Ravi Vora on 25/8/2563 BE.
//  Copyright © 2563 Ravi Vora. All rights reserved.
//

import Foundation
import SwiftyJSON

final class CarListService {
    
    /*
     This method will fetch cars from Webservice.
     */
    
    func fetchCarList(request: CarListModel.Request,
                         success: @escaping (JSON) -> (),
                         fail: @escaping (_ httpStatus: Int?, _ errorCode: String?) -> ()) {
        
        if Tools.shared.hasConnectivity() == false {
            Tools.shared.hideProgressHUD()
        }
        
        let api = APIManager.init(endpoint: .fetchArticles)
        let dict:  [String: AnyObject] =  [String: AnyObject]()
        api.call(parameters: dict, headersAdditional: nil, encoding: nil, fail: { (status, code) in
            fail(status, code)
        }) { (json) in
            success(json)
        }
    }
}
