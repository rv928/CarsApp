//
//  CarListModels.swift
//  Cars
//
//  Created by Ravi Vora on 25/8/2563 BE.
//  Copyright © 2563 Ravi Vora. All rights reserved.
//

import Foundation
import SwiftyJSON

struct CarListModel {
    
    struct Request {
        
    }
    
    // Data struct sent to Presenter
    struct Response {
        
        public class CarList {
            
            var car: [Car]?
            
            init(json: JSON) {
                let cars = json["content"].arrayValue
                self.car = []
                for car in cars {
                    self.car?.append(Car(json: car))
                }
            }
            
            init(cars: [Car]) {
                self.car = cars
            }
        }
        
        struct Car {
            var id: Int64
            var title: String?
            var description: String?
            var dateTime: String?
            var imageURL: String?
            
            init(json: JSON) {
                self.id = json["id"].int64!
                self.title  = json["title"].string ?? ""
                self.description = json["content"][0]["description"].string ?? ""
                self.dateTime = json["dateTime"].string ?? ""
                self.imageURL = json["image"].string ?? ""
            }
            
            init(_ id: Int64 ,_ title: String, _ description: String, _ dateTime: String ,_ imageURL: String) {
                self.id = id
                self.title = title
                self.description = description
                self.dateTime = dateTime
                self.imageURL = imageURL
            }
        }
    }
    
    // Data struct sent to ViewController
    struct ViewModel {
        let title: String
        let description: String
        let dateTime: String
        let imageURL: String
        
        init(with car: Response.Car) {
            self.title = car.title ?? ""
            self.description = car.description ?? ""
            self.imageURL = car.imageURL ?? ""
            
            if car.dateTime != "" {
                // 25.12.2017 14:13
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "dd.MM.yyyy HH:mm"
                let date = dateFormatter.date(from: car.dateTime!)
                
                // checking for same year condition
                let intervalYear = Date() - date!
                if (intervalYear.year ?? 0 == 0) {
                    dateFormatter.dateFormat = "dd MMM, hh:mm a"
                } else {
                    dateFormatter.dateFormat = "dd MMM yyyy, hh:mm a"
                }
                let dateString:String = dateFormatter.string(from: date!)
                self.dateTime = dateString
                //25 December 2017, 02:13 PM
            } else {
                self.dateTime = ""
            }
        }
    }
}
