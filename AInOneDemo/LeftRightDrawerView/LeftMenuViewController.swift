//
//  LeftMenuViewController.swift
//  AssanUser
//
//  Created by Sensu Soft on 31/07/17.
//  Copyright © 2017 Sensussoft. All rights reserved.
//

import UIKit
//let KEY_SIDEMENU_IMAGE = "SIDEMENU_IMAGE"
//let KEY_SIDEMENU_ITEM = "SIDEMENU_ITEM"
//let KEY_SIDEMENU_SELECTED = "KEY_SIDEMENU_SELECTED"

class LeftMenuViewController: UIViewController {
    
    @IBOutlet weak var tblView: UITableView!
    
    var arrListMenu = [[String: AnyObject]]()
    
    typealias CompletionBlock = (IndexPath,_ isOpenHome: Bool) -> Void
    var menuClickBlock : CompletionBlock!
    var leftDrawerTransition:DrawerTransition!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doSetupUI()
    }
    
    func doSetupUI() {

        var lblHomeTitle = ""
        if let strHome = appDelegate.localizationModel.SlideMenu_Home,
            strHome.count > 0 {
            lblHomeTitle = strHome
        } else {
            lblHomeTitle = "Home"
        }
        
        var lblMyAccountTitle = ""
        if let strHome = appDelegate.localizationModel.SlideMenu_MyAccount,
            strHome.count > 0 {
            lblMyAccountTitle = strHome
        } else {
            lblMyAccountTitle = "Home"
        }
        
        
        //SlideMenu_Home
        arrListMenu = [
            [
                "title" : lblHomeTitle as AnyObject ,
                "image" : #imageLiteral(resourceName: "ic_my_playfies") as AnyObject,
                "is_selected" : true as AnyObject,
                ],
            [
                "title" : lblMyAccountTitle as AnyObject,
                "image" : #imageLiteral(resourceName: "ic_MyAccount") as AnyObject,
                "is_selected" : false as AnyObject,
                ],
            [:],
            [
                "title" : appDelegate.localizationModel.SlideMenu_AboutPlayfie as AnyObject,
                "image" : #imageLiteral(resourceName: "ic_about") as AnyObject,
                "is_selected" : false as AnyObject,
                ],
            [
                "title" : appDelegate.localizationModel.SlideMenu_HelpCenter as AnyObject,
                "image" : #imageLiteral(resourceName: "ic_help_center") as AnyObject,
                "is_selected" : false as AnyObject,
                ],
            [
                "title" : appDelegate.localizationModel.SlideMenu_Prices as AnyObject,
                "image" : #imageLiteral(resourceName: "ic_price") as AnyObject,
                "is_selected" : false as AnyObject,
                ],
            [:],
            [
                "title" : appDelegate.localizationModel.SlideMenu_Logout as AnyObject,
                "image" : #imageLiteral(resourceName: "ic_logout") as AnyObject,
                "is_selected" : false as AnyObject,
                ]
        ]
        
        tblView.register(UINib.init(nibName: "SideMenuCell", bundle: nil), forCellReuseIdentifier: "SideMenuCell")
        tblView.delegate = self
        tblView.dataSource = self
        tblView.tableFooterView = UIView()
        tblView.reloadData()

    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(notifyLanguageChange(notfication:)),
                                               name: NSNotification.Name(rawValue: "notifyLanguageChange"),
                                               object: nil)
        
//        for i in 0 ..< self.arrListMenu.count
//        {
//            if(i==0)
//            {
//                self.arrListMenu[i][KEY_SIDEMENU_SELECTED] = "true"
//            }
//            else
//            {
//                self.arrListMenu[i][KEY_SIDEMENU_SELECTED] = "false"
//            }
//            self.tblView.reloadData()
//        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "notifyNewLocationChange"), object: nil)
        
        doSetupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        doSetupUI()
        
    }
    
    func clickCellEvent(completion : @escaping CompletionBlock)  {
        menuClickBlock = completion
    }
    
    //MARK : - IBACTION METHODS
    
    @IBAction func btnProfile_Click(_ sender: UIButton) {
       // menuClickBlock(IndexPath(row: 10, section: 0),)
        menuClickBlock(IndexPath(row: 10, section: 0),false)
    }
    
    @IBAction func btnActionLogout(_ sender: UIButton) {
       // menuClickBlock(IndexPath(row: 6, section: 0))
        menuClickBlock(IndexPath(row: 10, section: 0),false)
    }
    
    @objc func notifyLanguageChange(notfication: NSNotification) {
        doSetupUI()
    }
    
}

extension LeftMenuViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return arrListMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SideMenuCell = tableView.dequeueReusableCell(withIdentifier: "SideMenuCell") as! SideMenuCell
        
        var dict : [String: AnyObject] = self.arrListMenu[indexPath.row]
        if(dict.count > 0)
        {
            cell.img.image = dict["image"] as? UIImage
            cell.lblItem.text = dict["title"]!.description
        }
        else
        {
            cell.img.image = nil
            cell.lblItem.text = ""
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dict = arrListMenu[indexPath.row]
        if dict["title"] != nil {
            if "\(String(describing: dict["title"]!))" == "\(appDelegate.localizationModel.SlideMenu_Home as AnyObject)"{
                menuClickBlock(indexPath,true)
            } else {
                menuClickBlock(indexPath,false)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(self.arrListMenu[indexPath.row].count == 0) {
            return 15
        } else if(indexPath.row == 5) || (indexPath.row == 4)  {
            return 0
        }
        return 50
    }
}
