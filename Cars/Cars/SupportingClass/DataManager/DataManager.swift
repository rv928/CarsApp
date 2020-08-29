//
//  DataManager.swift

import Foundation
import CoreData
import UIKit

class DataManager {
    
    static let fetch: DataManager = {
        let instance = DataManager()
        return instance
    }()
    
    private init() {}
    
    /*
     * This method will save CarList into Core data
     */
   
    func saveCarList(carList: [CarListModel.Response.Car],
                     success: @escaping ([CarListModel.Response.Car]?) -> (),
                     fail: @escaping (_ error: String?) -> ()) {
        
        for(index,_) in carList.enumerated() {
            
            let currentCar: CarListModel.Response.Car = carList[index]
            
            DispatchQueue.main.async {
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let context = appDelegate.persistentContainer.viewContext
                
                var listArray:Array<Any> = Array()
                
                //Check For Duplicate
                let request = NSFetchRequest<NSFetchRequestResult>(entityName: ENTITY)
                request.returnsObjectsAsFaults = false
                do {
                    let result = try context.fetch(request)
                    for data in result as! [NSManagedObject] {
                        var dataDict:Dictionary<String,Any> = Dictionary()
                        dataDict[ATTR_id] = data.value(forKey: ATTR_id) as! Int64
                        listArray.append(dataDict)
                    }
                } catch {
                    print("Failed")
                    fail(error as? String)
                }
                
                var isFound:Bool = false
                for(index,_) in listArray.enumerated() {
                    let currentDict:Dictionary<String,Any> =  listArray[index] as! Dictionary<String, Any>
                    if Int(truncatingIfNeeded: currentDict[ATTR_id] as! Int64) == currentCar.id {
                        isFound = true
                        break
                    }
                }
                
                if isFound == false {
                    let entity = NSEntityDescription.entity(forEntityName: ENTITY, in: context)
                    let newTerm = NSManagedObject(entity: entity!, insertInto: context)
                    newTerm.setValue(currentCar.id, forKey: ATTR_id)
                    newTerm.setValue(currentCar.title, forKey: ATTR_title)
                    newTerm.setValue(currentCar.description, forKey: ATTR_desc)
                    newTerm.setValue(currentCar.imageURL, forKey: ATTR_image)
                    newTerm.setValue(currentCar.dateTime, forKey: ATTR_dateTime)
                    
                    do {
                        try context.save()
                    } catch {
                        print("Failed saving")
                        fail(error as? String)
                    }
                } else {
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:ENTITY)
                    
                    fetchRequest.predicate = NSPredicate(format: "id = %d",
                                                         argumentArray: [currentCar.id])
                    do {
                        let results = try context.fetch(fetchRequest) as? [NSManagedObject]
                        if results?.count != 0 {
                            results![0].setValue(currentCar.id, forKey: ATTR_id)
                            results![0].setValue(currentCar.title, forKey: ATTR_title)
                            results![0].setValue(currentCar.description, forKey: ATTR_desc)
                            results![0].setValue(currentCar.dateTime, forKey: ATTR_dateTime)
                            results![0].setValue(currentCar.imageURL, forKey: ATTR_image)
                        }
                    } catch {
                        print("Fetch Failed: \(error)")
                        fail(error as? String)
                    }
                    do {
                        try context.save()
                    } catch {
                        print("Failed saving")
                        fail(error as? String)
                    }
                }
            }
        }
    
        self.getCarList(success: { (savedCarList) in
            success(savedCarList)
        }) { (error) in
            fail(error)
        }
    }
    
    /*
     * This method will fetch CarList from Core data
     */
    func getCarList(success: @escaping ([CarListModel.Response.Car]?) -> (),
                    fail: @escaping (_ error: String?) -> ()) {
        
        var savedList: [CarListModel.Response.Car] = []
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<NSFetchRequestResult>(entityName:ENTITY)
            request.returnsObjectsAsFaults = false
            do {
                let result = try context.fetch(request)
                for data in result as! [NSManagedObject] {
                    
                    var outputDict:Dictionary<String,Any> = Dictionary()
                    
                    outputDict[ATTR_id] = Int64(truncatingIfNeeded: data.value(forKey: ATTR_id) as! Int64)
                    outputDict[ATTR_title] = data.value(forKey: ATTR_title) as! String
                    outputDict[ATTR_desc] = data.value(forKey: ATTR_desc) as! String
                    outputDict[ATTR_dateTime] = data.value(forKey: ATTR_dateTime) as! String
                    outputDict[ATTR_image] = data.value(forKey: ATTR_image) as! String
                    
                    //model
                    let carModel: CarListModel.Response.Car = CarListModel.Response.Car(outputDict[ATTR_id] as! Int64,
                                                                                        outputDict[ATTR_title] as! String,
                                                                                        outputDict[ATTR_desc] as! String,
                                                                                        outputDict[ATTR_dateTime] as! String,
                                                                                        outputDict[ATTR_image] as! String)
                    savedList.append(carModel)
                }
                success(savedList)
            } catch {
                print("Failed")
                fail(error as? String)
            }
        }
    }
    
    /*
     * This method will fetch Article Detail from Core data
     */
    func getArticleDetail(articleID: Int, completion: @escaping (_ carDetail: CarListModel.Response.Car?) -> Void) {
        //Check For Record
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: ENTITY)
            request.predicate = NSPredicate(format: "id == %lld", Int64(truncatingIfNeeded: articleID))
            do {
                let results = try context.fetch(request)
                var outputDict:Dictionary<String,Any> = Dictionary()
                if let data:NSManagedObject = results.first as? NSManagedObject {
                    outputDict[ATTR_id] = Int(truncatingIfNeeded: data.value(forKey: ATTR_id) as! Int)
                    outputDict[ATTR_title] = data.value(forKey: ATTR_title) as! String
                    outputDict[ATTR_desc] = data.value(forKey: ATTR_desc) as! String
                    outputDict[ATTR_image] = data.value(forKey: ATTR_image) as! String
                    outputDict[ATTR_dateTime] = data.value(forKey: ATTR_dateTime) as! String
                    
                    //model
                    let carModel: CarListModel.Response.Car = CarListModel.Response.Car(outputDict[ATTR_id] as! Int64 ,
                                                                                        outputDict[ATTR_title] as! String,
                                                                                        outputDict[ATTR_desc] as! String,
                                                                                        outputDict[ATTR_dateTime] as! String,
                                                                                        outputDict[ATTR_image] as! String)
                    completion(carModel)
                } else {
                    completion(nil)
                }
            } catch {
                print("Failed")
                completion(nil)
            }
        }
    }
}
