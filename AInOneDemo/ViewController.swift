//
//  ViewController.swift
//  AInOneDemo
//
//  Created by Puja Rathod on 13/06/19.
//  Copyright © 2019 Puja Rathod. All rights reserved.
//

import UIKit
import CoreData
import Alamofire
import MBProgressHUD

class ViewController: UIViewController {
   let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var context:NSManagedObjectContext?
    var arrEmployee:[EmployeeModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let arrFromLocal =  self.CD_GetData(),
            arrFromLocal.count > 0 {
            print("get Data from local :-\(arrFromLocal)")
        } else {
            self.getData()
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
}
extension ViewController {
    private func showLoadingHUD() {
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = "Loading..."
    }
    
    private func hideLoadingHUD() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func postData() {
        self.showLoadingHUD()
        Alamofire.request("http://dummy.restapiexample.com.com/api/v1/create", method:.post, parameters: nil).responseJSON { (jsonDataToVerify) in
            
            if(jsonDataToVerify.result.value == nil) {
               self.hideLoadingHUD()
            }
           else
            {
               self.hideLoadingHUD()
                if let responseDic = jsonDataToVerify.result.value as? [String:Any] {
                   print("responseDic:-\(responseDic)")
                }
            }
        }
    }
    
    func getData() {
        self.showLoadingHUD()
        Alamofire.request(
            "http://dummy.restapiexample.com/api/v1/employees",
            method: .get).responseJSON(completionHandler: { (jsonDataToVerify) in
                self.hideLoadingHUD()
                if let arrDic = jsonDataToVerify.result.value as? [[String:Any]] {
                    for obj in arrDic {
                        if let empObj = EmployeeModel.init(data: obj) {
                            self.arrEmployee.append(empObj)
                            self.CD_SaveData(modelObj: empObj)
                        }
                    }
                }
            })
    }
    
    func CD_SaveData(modelObj:EmployeeModel)  {
        context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Employee", in: context!)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        newUser.setValue(modelObj.id, forKey: "empId")
        newUser.setValue(modelObj.employeeName, forKey: "empName")
        newUser.setValue(modelObj.employeeSalary, forKey: "empSalary")
        do {
            try context!.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func CD_GetData()  -> [EmployeeModel]?{
        context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Employee")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context!.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "empName") as! String)
                if let obj = EmployeeModel(data: data) {
                    self.arrEmployee.append(obj)
                }
            }
            print("Got the data:- \(self.arrEmployee)")
            return self.arrEmployee
        } catch {
            print("Failed")
            return nil
        }
    }
}

