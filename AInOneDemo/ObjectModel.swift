//
//  ObjectModel.swift
//  AInOneDemo
//
//  Created by Puja Rathod on 14/06/19.
//  Copyright © 2019 Puja Rathod. All rights reserved.
//

import Foundation
import CoreData

struct EmployeeModel {
    var id:String?
    var employeeAge : String?
    var employeeName : String?
    var employeeSalary : String?
    
    init?(data:[String :Any]) {
        if let eId = data["id"] as? String {
            self.id = eId
            
            if let empAge = data["employee_age"] as? String {
                self.employeeAge = empAge
            }
            
            if let empName = data["employee_name"] as? String {
                self.employeeName = empName
            }
            
            if let empSal = data["employee_salary"] as? String {
                self.employeeSalary = empSal
            }
            
        } else {
            return nil
        }
    }
    
    init?(data:NSManagedObject) {
        self.employeeName = data.value(forKey: "empName") as? String
        self.employeeSalary = data.value(forKey: "empSalary") as? String
        self.id = data.value(forKey: "empId") as? String
    }
    
}
