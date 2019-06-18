//
//  BaseViewController.swift
//  CityOfWishes
//
//  Created by Sensu Soft on 22/01/18.
//  Copyright © 2018 sensussoft. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit

class BaseViewController: UIViewController {
    
    typealias completionBlock = (_ isCartButton:Bool)->()
    typealias completionMenuBlock = ()->()
    var btnClickBlock : completionBlock!
    var strNextTital : String!
    var leftDrawerTransition:DrawerTransition!
    var left = LeftMenuViewController()
    var lblCount:UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setBackButtonNavigation() {
        self.navigationController?.navigationBar.isHidden = false
        let btnback = UIButton(type: .custom)
        btnback.setImage(#imageLiteral(resourceName: "ic_back"), for: .normal)
        btnback.frame = CGRect(x: -10, y: 0, width: 35, height: 40)
        btnback.showsTouchWhenHighlighted = true
        btnback.addTarget(self, action: #selector(self.btnback_Click), for: .touchUpInside)
        let leftBarButtonItems = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
        leftBarButtonItems.addSubview(btnback)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButtonItems)
    }
    
    func setCloseButtonNavigation() {
        self.navigationController?.navigationBar.isHidden = false
        let btnback = UIButton(type: .custom)
        btnback.setImage(#imageLiteral(resourceName: "ic_cancel"), for: .normal)
        btnback.frame = CGRect(x: -10, y: 0, width: 35, height: 40)
        btnback.showsTouchWhenHighlighted = true
        btnback.addTarget(self, action: #selector(self.btnback_Click), for: .touchUpInside)
        let leftBarButtonItems = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
        leftBarButtonItems.addSubview(btnback)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButtonItems)
    }
    
    func setMenuButtonNavigation() {
        self.navigationController?.navigationBar.isHidden = false
        let btnMenu = UIButton(type: .custom)
        let img: UIImage = UIImage.init(named: "ic_menu")!
        btnMenu.setImage(img, for: .normal)
        btnMenu.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btnMenu.showsTouchWhenHighlighted = true
        btnMenu.addTarget(self, action: #selector(self.btnmenu_Click), for: .touchUpInside)
        let leftBarButtonItems = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        leftBarButtonItems.addSubview(btnMenu)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButtonItems)
    }
    
    func SetNavigationSize(Constraints : NSLayoutConstraint)
    {
        if IS_IPHONE_X()
        {
            Constraints.constant = 84
        }else
        {
            Constraints.constant = 64
        }
    }
    
    func SetBottomSize(Constraints : NSLayoutConstraint)
    {
        if IS_IPHONE_X()
        {
            Constraints.constant = 60
        }else
        {
            Constraints.constant = -60
        }
    }
    
    func setNotificationButton() {
        
        let btnAddProduct = UIButton(type: .custom)
        btnAddProduct.setImage(UIImage(named: "ic_notification"), for: .normal)
        btnAddProduct.frame = CGRect(x: 0, y: 0, width: 30, height: 40)
        btnAddProduct.showsTouchWhenHighlighted = true
        btnAddProduct.addTarget(self, action: #selector(self.btnRight_click), for: .touchUpInside)
        let rightBarButtonItems = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
        rightBarButtonItems.addSubview(btnAddProduct)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarButtonItems)
    }
    
    func setRightLogoButton() {
        let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        img.image = #imageLiteral(resourceName: "logo")
        
        let rightBarButtonItems = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        rightBarButtonItems.addSubview(img)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBarButtonItems)
    }
    
    @IBAction func btnback_Click(_ sender: Any) {
        self.btnClickBlock(true)
    }
    
    @IBAction func btnRight_click(_ sender: Any) {
        self.btnClickBlock(false)
        
    }
    
    @IBAction func btnmenu_Click(_ sender: Any) {
        self.setSideMenu()
    }
    
    func setNavigationTitle(str:String) {
        self.title = str
    }
    
    func pressButtonOnNavigaion(completion : @escaping completionBlock) {
        btnClickBlock = completion
    }
    
    @objc func setSideMenu() {
        self.leftDrawerTransition.presentDrawerViewController(animated: true)
    }
    
    //MARK: - Left drawer
    func setupLeftDrawer(_ controller: UIViewController) {
        
        self.leftDrawerTransition = DrawerTransition(target: controller, drawer: left)
        self.leftDrawerTransition.setPresentCompletion { print("left present...") }
        self.leftDrawerTransition.setDismissCompletion {  }
        self.leftDrawerTransition.edgeType = .left
        
        
        left.clickCellEvent { (indexpath,isOpen) in
            if(indexpath.row == 0)
            {
                let vc = HomeViewController(nibName: "HomeViewController", bundle: nil)
                if !isOpen{ self.navigationController?.pushViewController(vc, animated: true) }
                
            }
            else if(indexpath.row == 1)
            {
               
                let vc = MyAccountViewController(nibName: "MyAccountViewController", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if(indexpath.row == 3)
            {
                let vc = AboutViewController(nibName: "AboutViewController", bundle: nil)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if(indexpath.row == 4)
            {
                let vc:HelpCenterVC = storyBoard.instantiateViewController(withIdentifier: "HelpCenterVC") as! HelpCenterVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if(indexpath.row == 5)
            {
                let vc = PricesViewController(nibName: "PricesViewController", bundle: nil)
                //appDelegate.navigationview(viewController: vc)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else if(indexpath.row == 7)
            {
                self.LogOut()
            }
            
            self.leftDrawerTransition.dismissDrawerViewController()
        }
     }
    
    func clearSessionForLogout(){
        GIDSignIn.sharedInstance().signOut()
        FBSDKLoginManager().logOut()
        AIUser.sharedManager.logout()
        CommonUtils.shared().setIntroViewController()
    }
    func callRemoveLocalPlayfies() {
        if let arrMyPlayfies = UserDefaultManager.getDraftPlayfileList() {
            if arrMyPlayfies.count > 0 {
                let obj = arrMyPlayfies.filter({$0.appUserId == AIUser.sharedManager.User_Id})
                if obj.count > 0 {
                    let objLocalPlayfieUId = obj[0].appUserId
                    if objLocalPlayfieUId == AIUser.sharedManager.User_Id {
                        displayAlertWithTitle(APP_NAME, andMessage: "Are you sure you want to delete your local playfie?", buttons: [appDelegate.localizationModel.title_dialog_btn_no ??  "NO",appDelegate.localizationModel.title_dialog_btn_yes ?? "YES"], completion: { (index) in
                            if(index == 1) {
                                UserDefaultManager.removeDraftPlayfileListByUsderId(userId: objLocalPlayfieUId!)
                                self.clearSessionForLogout()
                            } else {
                               self.clearSessionForLogout()
                            }
                        })
                    } else {
                       self.clearSessionForLogout()
                    }
                } else {
                    self.clearSessionForLogout()
                }
            } else {
               self.clearSessionForLogout()
            }
        } else {
            self.clearSessionForLogout()
        }
    }
    
    func callUserLogout()
    {
        var param = [String:AnyObject]()
        param["User_Id"] = AIUser.sharedManager.User_Id as AnyObject
        param["Session_Id"] = AIUser.sharedManager.Session_Id as AnyObject
        let preferredLanguage = NSLocale.init(localeIdentifier:NSLocale.preferredLanguages[0]).languageCode.uppercased()
        param["language_name"] = preferredLanguage as AnyObject?
        
        ANlog(param)
        ServiceManager.apiUserLogoutWithParameters(param){ (isSuccess,str, dicJson) in
            if (isSuccess)
            {
//                UserDefaults.standard.set("", forKey: "CurrentDate")
//                self.callRemoveLocalPlayfies()
                self.clearSessionForLogout()
                appDelegate.setAppLanguage()
            }
        }
    }
    
    func callUserRemoveAccount() {
        var param = [String:AnyObject]()
        param["User_Id"] = AIUser.sharedManager.User_Id as AnyObject
        param["Session_Id"] = AIUser.sharedManager.Session_Id as AnyObject
        
        ANlog(param)
        ServiceManager.apiUserRemoveAccountWithParameters(param){ (isSuccess,str, dicJson) in
            if (isSuccess)
            {
                //                UserDefaults.standard.set("", forKey: "CurrentDate")
                //                self.callRemoveLocalPlayfies()
                self.clearSessionForLogout()
                appDelegate.setAppLanguage()
            }
        }
    }
        
    func LogOut() {
        self.leftDrawerTransition.dismissDrawerViewController()
        displayAlertWithTitle(APP_NAME, andMessage: appDelegate.localizationModel.logout_msg ?? "Are you sure you want to logout?", buttons: [appDelegate.localizationModel.title_dialog_btn_no ??  "NO",appDelegate.localizationModel.title_dialog_btn_yes ?? "YES"], completion: { (index) in
            if(index == 1) {
                self.callUserLogout()
//                self.callRemoveLocalPlayfies()
//                UserDefaults.standard.removeObject(forKey:"CurrentDate")
//                appDelegate.setAppLanguage()
            }
        })
    }
    
}
