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

extension ViewController {
    func setDashboardViewController()
    {
//        let VC = HomeViewController(nibName: "HomeViewController", bundle: nil)
//        appDelegate.navigationController = UINavigationController(rootViewController: VC)
//        appDelegate.navigationController?.navigationBar.isHidden = true
//        appDelegate.window?.rootViewController = appDelegate.navigationController
//        appDelegate.window?.makeKeyAndVisible()
    }
    
    func callSignUpAPI() {
//        var param = [String:AnyObject]()
//        param["User_FirstName"] = txtFname.text as AnyObject
//        param["User_LastName"] = txtSerName.text as AnyObject
//        param["User_Email"] = txtEmail.text as AnyObject
//        param["User_Password"] = txtPass.text as AnyObject
//        param["Device_Token"] = getUserDefaultValue("Token") as AnyObject?
//        param["Device_Type"] = DEVICE_TYPE as AnyObject
//        param["agreementText_Id"] = self.GDPRVersion as AnyObject
//        
//        ShowLoaderOnView()
//        Alamofire.upload(multipartFormData: { (multipartFormData) in
//            
//            for (key,value) in param {
//                multipartFormData.append((value.data(using: String.Encoding.utf8.rawValue, allowLossyConversion: false))!, withName: key)
//            }
//            
//            if(self.image != nil){
//                if let image1 = UIImageJPEGRepresentation(self.image!, 0.4) {
//                    multipartFormData.append(image1, withName: "User_Profile", fileName: "profile.png", mimeType: "image/jpg")
//                }
//            }
//            
//        }, to: URL_SIGNUP, encodingCompletion: { (result) in
//            // code
//            switch result {
//            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
//                upload.validate().responseJSON {
//                    response in
//                    HideLoaderOnView()
//                    if response.result.isFailure {
//                        debugPrint(response)
//                    } else {
//                        let result = response.value as! NSDictionary
//                        print(result)
//                        if(result.object_forKeyWithValidationForClass_Int("success") == 1){
//                            if let dicResp = result.value(forKey: "response") as? [String : AnyObject] {
//                                AIUser.sharedManager.setvalueUserWithdetails(dict:dicResp)
//                                if let isUsrVerified = dicResp["is_verified"] as? Int {
//                                    if isUsrVerified == 1 {
//                                        //Store popup
////                                        AIUser.sharedManager.saveInDefaults()
////                                        CommonUtils.shared().setDashboardViewController()
//                                    } else {
//                                        if let strUID = dicResp["User_Id"] as? String {
//                                            self.showOTPPopUp(strOtp: dicResp["otp"]!.description!, strUId: strUID)
//                                        }
//                                    }
//                                }
//                            } else {
//                                if let dicResp = result.value(forKey: "response") as? [String : AnyObject] {
//                                    if let strUID = dicResp["User_Id"] as? String,
//                                        let intValue = Int(strUID),
//                                        intValue > 0 {
//                                        displayAlertWithTitle(APP_NAME, andMessage: result.object_forKeyWithValidationForClass_String("message"), buttons: ["Ok"], completion: { (index) in
//                                            self.navigationController?.popViewController(animated: true)
//                                        })
//                                    }
//                                } else {
//                                    displayAlertWithMessage(result.object_forKeyWithValidationForClass_String("message"))
//                                }
//                            }
//                        } else {
//                            
//                            if let dicResp = result.value(forKey: "response") as? [String : AnyObject] {
//                                if let strUID = dicResp["User_Id"] as? String,
//                                    let intValue = Int(strUID),
//                                    intValue > 0 {
//                                    displayAlertWithTitle(APP_NAME, andMessage: result.object_forKeyWithValidationForClass_String("message"), buttons: ["Ok"], completion: { (index) in
//                                        //                                        self.navigationController?.popViewController(animated: true)
//                                    })
//                                }
//                            } else {
//                                displayAlertWithMessage(result.object_forKeyWithValidationForClass_String("message"))
//                            }
//                        }
//                    }
//                }
//            case .failure(let encodingError):
//                HideLoaderOnView()
//                NSLog((encodingError as NSError).localizedDescription)
//            }
//        })
//        
    }
    
    
}
