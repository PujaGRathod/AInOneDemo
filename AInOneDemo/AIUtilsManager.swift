
//
//  AIUtilsManager.swift
//  Swift3CodeStructure
//
//  Created by Ravi Alagiya on 25/11/2016.
//  Copyright © 2016 Ravi Alagiya. All rights reserved.
//

import Foundation
import UIKit

let CUSTOM_ERROR_DOMAIN = "CUSTOM_ERROR_DOMAIN"
let CUSTOM_ERROR_USER_INFO_KEY = "CUSTOM_ERROR_USER_INFO_KEY"

// MARK: - INTERNET CHECK

func IS_INTERNET_AVAILABLE() -> Bool{
    return AIReachabilityManager.sharedManager.isInternetAvailableForAllNetworks()
}

func SHOW_INTERNET_ALERT(){
    HIDE_CUSTOM_LOADER()
    HIDE_NETWORK_ACTIVITY_INDICATOR()
    
    displayAlertWithTitle(APP_NAME, andMessage: appDelegate.localizationModel.generalError_No_network_found ?? "Please check your internet connection and try again.", buttons: ["Dismiss"], completion: nil)
}

// MARK: - ALERT
func displayAlertWithMessage(_ message:String) -> Void {
    displayAlertWithTitle(APP_NAME, andMessage: message, buttons: ["OK"], completion: nil)
}

func displayWindowAlertWithMessage(_ message:String){
    let alert = UIAlertController(title: APP_NAME, message: message, preferredStyle: .alert)
    let window = UIWindow(frame: UIScreen.main.bounds)
    window.rootViewController = UIViewController()
    let okAction = UIAlertAction(title: "OK", style: .default) { (action) -> Void in
        alert.dismiss(animated: true, completion: nil)
        window.resignKey()
        window.isHidden = true
        window.removeFromSuperview()
        window.windowLevel = UIWindowLevelAlert - 1
        window.setNeedsLayout()
    }
    
    alert.addAction(okAction)
    window.windowLevel = UIWindowLevelAlert + 1
    window.makeKeyAndVisible()
    
    window.rootViewController?.present(alert, animated: true, completion: nil)
}

func displayAlertWithMessage(_ message:String, target : UIViewController) -> Void {
    displayAlertWithTitle(APP_NAME, andMessage: message, buttons: ["OK"], target : target, completion: nil)
}

func displayAlertWithMessageFromVC(_ vc:UIViewController, message:String, buttons:[String], completion:((_ index:Int) -> Void)!) -> Void {
    
    let alertController = UIAlertController(title: APP_NAME, message: message, preferredStyle: .alert)
    
    for index in 0..<buttons.count	{
        
        alertController.setValue(NSAttributedString(string: APP_NAME, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16),NSAttributedStringKey.foregroundColor : APP_HEADER_TEXT_COLOR]), forKey: "attributedTitle")
        
        alertController.setValue(NSAttributedString(string: message, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14),NSAttributedStringKey.foregroundColor : APP_HEADER_TEXT_COLOR]), forKey: "attributedMessage")
        
        
        let action = UIAlertAction(title: buttons[index], style: .default, handler: {
            (alert: UIAlertAction!) in
            if(completion != nil){
                completion(index)
            }
        })
        
        action.setValue(UIColor.black, forKey: "titleTextColor")
        alertController.addAction(action)
    }
    
    vc.present(alertController, animated: true, completion: nil)
}

func displayAlertWithTitle2(_ title:String, andMessage message:String, buttons:[String], completion:((_ index:Int) -> Void)!) -> Void {
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    for index in 0..<buttons.count    {
        
        alertController.setValue(NSAttributedString(string: title, attributes: [NSAttributedStringKey.font : UIFont.init(name: FONT_SF_REGULAR, size: 17)!,NSAttributedStringKey.foregroundColor : UIColor.black]), forKey: "attributedTitle")
        
        alertController.setValue(NSAttributedString(string: message, attributes: [NSAttributedStringKey.font : UIFont.init(name: FONT_SF_REGULAR, size: 14)!,NSAttributedStringKey.foregroundColor : APP_HEADER_TEXT_COLOR]), forKey: "attributedMessage")
        
        
        let action = UIAlertAction(title: buttons[index], style: .default, handler: {
            (alert: UIAlertAction!) in
            if(completion != nil){
                completion(index)
            }
        })
        
        action.setValue(UIColor.black, forKey: "titleTextColor")
        alertController.addAction(action)
    }
    UIApplication.shared.delegate!.window!?.rootViewController!.present(alertController, animated: true, completion:nil)
}


func displayAlertWithTitle(_ title:String, andMessage message:String, buttons:[String], completion:((_ index:Int) -> Void)!) -> Void {
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    for index in 0..<buttons.count	{
        
        alertController.setValue(NSAttributedString(string: title, attributes: [NSAttributedStringKey.font : UIFont.init(name: FONT_SF_REGULAR, size: 17)!,NSAttributedStringKey.foregroundColor : UIColor.black]), forKey: "attributedTitle")
        
        alertController.setValue(NSAttributedString(string: message, attributes: [NSAttributedStringKey.font : UIFont.init(name: FONT_SF_REGULAR, size: 14)!,NSAttributedStringKey.foregroundColor : APP_HEADER_TEXT_COLOR]), forKey: "attributedMessage")
        
        
        let action = UIAlertAction(title: buttons[index], style: .default, handler: {
            (alert: UIAlertAction!) in
            if(completion != nil){
                completion(index)
            }
        })
        
        action.setValue(UIColor.black, forKey: "titleTextColor")
        alertController.addAction(action)
    }
    UIApplication.shared.delegate!.window!?.rootViewController!.present(alertController, animated: true, completion:nil)
}

func displayAlertWithTitle(_ title:String, andMessage message:String, buttons:[String], target : UIViewController, completion:((_ index:Int) -> Void)!) -> Void {
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    for index in 0..<buttons.count	{
        
        alertController.setValue(NSAttributedString(string: title, attributes: [NSAttributedStringKey.font : UIFont.init(name: FONT_SF_REGULAR, size: 17)!,NSAttributedStringKey.foregroundColor : UIColor.black]), forKey: "attributedTitle")
        
        alertController.setValue(NSAttributedString(string: message, attributes: [NSAttributedStringKey.font : UIFont.init(name: FONT_SF_REGULAR, size: 14)!,NSAttributedStringKey.foregroundColor : APP_HEADER_TEXT_COLOR]), forKey: "attributedMessage")
        
        
        let action = UIAlertAction(title: buttons[index], style: .default, handler: {
            (alert: UIAlertAction!) in
            if(completion != nil){
                completion(index)
            }
        })
        
        action.setValue(UIColor.black, forKey: "titleTextColor")
        alertController.addAction(action)
    }
    target.present(alertController, animated: true, completion:nil)
}


func displayAlertWithTitle(_ vc:UIViewController, title:String, andMessage message:String, buttons:[String], completion:((_ index:Int) -> Void)!) -> Void {
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    for index in 0..<buttons.count	{
        
        alertController.setValue(NSAttributedString(string: title, attributes: [NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 16),NSAttributedStringKey.foregroundColor : APP_HEADER_TEXT_COLOR]), forKey: "attributedTitle")
        
        alertController.setValue(NSAttributedString(string: message, attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14),NSAttributedStringKey.foregroundColor : APP_HEADER_TEXT_COLOR]), forKey: "attributedMessage")
        
        
        let action = UIAlertAction(title: buttons[index], style: .default, handler: {
            (alert: UIAlertAction!) in
            if(completion != nil){
                completion(index)
            }
        })
        
        action.setValue(UIColor.black, forKey: "titleTextColor")
        alertController.addAction(action)
    }
    vc.present(alertController, animated: true, completion: nil)
}

func SHOW_NETWORK_ACTIVITY_INDICATOR(){
    UIApplication.shared.isNetworkActivityIndicatorVisible =  true
}

func HIDE_NETWORK_ACTIVITY_INDICATOR(){
    UIApplication.shared.isNetworkActivityIndicatorVisible =  false
}

func isValidEmail(_ stringToCheckForEmail:String) -> Bool {
    let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: stringToCheckForEmail)
}

func isValidName(_ string:String) -> Bool {
    let emailRegex = "[a-zA-Z]{3,10}"
    return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: string)
}

func isValidMobileNumber(_ string:String) -> Bool {
//    let emailRegex = "^(?:(?:\\+|0{0,2})[0-9]+(\\s*[\\-]\\s*)?|[0]?)?[789]\\d{9}$"
    let trimmedString = string.replacingOccurrences(of: " ", with: "")
    let emailRegex = "^((\\+)|(00))[0-9]{6,14}$"
    return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: trimmedString)
}

func isValidMNumber(_string:String) -> Bool {
    let trimmedString = _string.replacingOccurrences(of: " ", with: "")
    let emailRegex = "^((\\+)|(00))[0-9]{6,12}$"
    return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: trimmedString)
}

//func isValidPassword(_ string:String) -> Bool {
//    let emailRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$" // Special character,one
//    return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: string)
//}

func isValidPassword(_ string:String) -> Bool {
    if string.count >= 8 {
        return true
    }
    return false
}

func isValidUnitNumber(_ string:String) -> Bool {
    let emailRegex = "[a-zA-Z0-9]{1,10}"
    return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: string)
}

func isValidateCourse(_ strToCheckCourseName: String) -> Bool {
    let courseName = "[A-Z0-9a-z]+"
    return NSPredicate(format: "SELF MATCHES %@", courseName).evaluate(with: strToCheckCourseName)
}

func isValidHashTag(_ str:String) -> Bool {
    let regex = "[A-Za-z0-9 #]+"
    return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: str)
}

// MARK: - DATE MERGING

func combineDateWithTime(date: NSDate, time: NSDate) -> NSDate? {
    let calendar = NSCalendar.current
    
    let dateComponents = calendar.dateComponents([.year,.month,.day], from: date as Date)
    
    let timeComponents = calendar.dateComponents([.hour, .minute, .second], from: time as Date)
    
    let mergedComponments = NSDateComponents()
    mergedComponments.year = dateComponents.year!
    mergedComponments.month = dateComponents.month!
    mergedComponments.day = dateComponents.day!
    mergedComponments.hour = timeComponents.hour!
    mergedComponments.minute = timeComponents.minute!
    mergedComponments.second = timeComponents.second!
    
    return calendar.date(from: mergedComponments as DateComponents) as NSDate?
}

// MARK:-  DATE STRING TO DATE TYPE CASTING //Formate : "yyyy-MM-dd'T'HH:mm:ssZ"

func appStringTODateConvert(strDate:String)-> String{
    let dateFormatter = DateFormatter()
    let tempLocale = dateFormatter.locale // save locale temporarily
    dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"  // "yyyy-MM-dd'T'HH:mm:ss.SSSZZ

    guard let date = dateFormatter.date(from: strDate) else {
        return appStringTODateConvertAnotherFormate(dateString: strDate)
    }

    dateFormatter.dateFormat = "MM/dd/yyyy"
    dateFormatter.locale = tempLocale // reset the locale
    let dateString = dateFormatter.string(from: date)
    
    return dateString.isEmpty ? "" : dateString
    
}

func appStringTODateConvertAnotherFormate(dateString:String)-> String{
    
    let dateFormatter = DateFormatter()
    let tempLocale = dateFormatter.locale // save locale temporarily
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    
    guard let date = dateFormatter.date(from: dateString) else {
        return ""
    }
    
    dateFormatter.dateFormat = "MM/dd/yyyy"
    dateFormatter.locale = tempLocale // reset the locale
    let dateString = dateFormatter.string(from: date)
    return dateString.isEmpty ? "" : dateString
    
}

func gateStringToDate(strDate:String) -> Date{
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    
    guard let date = dateFormatter.date(from: strDate) else {

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        
        guard let date1 = dateFormatter.date(from: strDate) else {
            return Date()
        }
        return date1
    }
    return date
}

func getOffsetFromCurrentDate(strDate:String) -> String {
    var returnValue = ""
    
    let dateCheck = gateStringToDate(strDate: strDate)
    
    let differenceComponent = NSCalendar.current.dateComponents([.second, .minute, .hour, .day, .month, .year], from: dateCheck, to: NSDate() as Date)

    
    if differenceComponent.year! > 0 || differenceComponent.month! > 0 || differenceComponent.day! > 2{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        returnValue = dateFormatter.string(from: dateCheck)
        
    }else if differenceComponent.day! <= 2{
        if differenceComponent.day == 1 {
            returnValue = "1d"
        }else{
            returnValue = String(format: "%dd", differenceComponent.day!)
        }
        
    }else if differenceComponent.hour! > 0{
        if differenceComponent.hour == 1 {
            returnValue = "1h"
        }else{
            returnValue = String(format: "%dh", differenceComponent.hour!)
        }
    }else if differenceComponent.minute! > 0{
        if differenceComponent.minute == 1 {
            returnValue = "1m"
        }else{
            returnValue = String(format: "%dm", differenceComponent.minute!)
        }
    }else if differenceComponent.second! >= 0{
        //returnValue = "Just Now"
            if differenceComponent.second == 1 {
                returnValue = "1s"
            }else{
                returnValue = String(format: "%ds", differenceComponent.second!)
            }
    }
    
    return returnValue
}

//MARK:- GENERAL METHODS

func setTextFieldPlaceHolderColor(txtField: UITextField!)
{
    txtField.attributedPlaceholder = NSAttributedString(string:txtField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: APP_PLACEHOLDER_COLOR])
}

func setTextFieldPlaceHolderColorWithCollection(txtCollection: [UITextField]!)
{
    for txt in txtCollection
    {
        txt.attributedPlaceholder = NSAttributedString(string:txt.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: APP_PLACEHOLDER_COLOR])
    }
}

func setGrayTextFieldPlaceHolderColorWithCollection(txtCollection: [UITextField]!)
{
    for txt in txtCollection
    {
        txt.attributedPlaceholder = NSAttributedString(string:txt.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: APP_GRAY_PLACEHOLDER_COLOR])
    }
}

func setLabelFontAndColorWithCollection(lblCollection : [UILabel]!, fontName : String!, fontSize: CGFloat!, textColor : UIColor!, bgColor : UIColor!)
{
    for lbl in lblCollection
    {
        lbl.font =  UIFont(name: fontName, size: fontSize)
        lbl.textColor = textColor
        
        if(bgColor != nil)
        {
            lbl.backgroundColor = bgColor
        }
    }
}

func setButtonFontAndColorWithCollection(btnCollection : [UIButton]!, fontName : String!, fontSize: CGFloat!, textColor : UIColor!, bgColor : UIColor!)
{
    for btn in btnCollection
    {
        btn.titleLabel?.font =  UIFont(name: fontName, size: fontSize)
        btn.titleLabel?.textColor = textColor
        
        if(bgColor != nil)
        {
            btn.backgroundColor = bgColor
        }
    }
}

func setTextFieldFontAndColorWithCollection(txtCollection : [UITextField]!, fontName : String!, fontSize: CGFloat!, textColor : UIColor!, bgColor : UIColor!)
{
    for txt in txtCollection
    {
        txt.font =  UIFont(name: fontName, size: fontSize)
        txt.textColor = textColor
        
        if(bgColor != nil)
        {
            txt.backgroundColor = bgColor
        }
    }
}

func setButtonImageColor(btn : UIButton! , color : UIColor!)
{
    let tintedImage = (btn.image(for: .normal))?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
    btn.setImage(tintedImage, for: .normal)
    btn.tintColor = color
}

func setImageViewImageColor(imgView : UIImageView! , color : UIColor!)
{
    imgView.image = imgView.image!.withRenderingMode(.alwaysTemplate)
    imgView.tintColor = color
}

func getImageUrl(strUrl : String!) -> String!
{
    return strUrl!.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
}

func applyGradientColor(control : UIView!, colors : [UIColor]!) {
    let layer : CAGradientLayer = CAGradientLayer()
    layer.frame.size = control.frame.size
    layer.frame.origin = CGPoint(x: 0, y: 0)
    
    var cgColors = [CGColor]()
    
    for i in 0 ..< colors.count
    {
        cgColors.append(colors[i].cgColor)
    }
    
    layer.colors = cgColors
    control.layer.insertSublayer(layer, at: 0)
}

func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
    return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
}

func resetDefaults() {
    let defaults = UserDefaults.standard
    let dictionary = defaults.dictionaryRepresentation()
    dictionary.keys.forEach { key in
        if(key != "Token" && key != CURRENT_LOCATION)
        {
            defaults.removeObject(forKey: key)
        }
    }
}

func ANlog(_ message : Any) {
    print(message)
}

//MARK:- DEVICE CHECK


//Check IsiPhone Device
func IS_IPHONE_DEVICE()->Bool{
    let deviceType = UIDevice.current.userInterfaceIdiom == .phone
    return deviceType
}

//Check IsiPad Device
func IS_IPAD_DEVICE()->Bool{
    let deviceType = UIDevice.current.userInterfaceIdiom == .pad
    return deviceType
}


//iPhone 4 OR 4S
func IS_IPHONE_4_OR_4S()->Bool{
    let SCREEN_HEIGHT_TO_CHECK_AGAINST:CGFloat = 480
    var device:Bool = false
    
    if(SCREEN_HEIGHT_TO_CHECK_AGAINST == SCREEN_HEIGHT)	{
        device = true
    }
    return device
}

//iPhone 5 OR OR 5C OR 4S
func IS_IPHONE_5_OR_5S()->Bool{
    let SCREEN_HEIGHT_TO_CHECK_AGAINST:CGFloat = 568
    var device:Bool = false
    if(SCREEN_HEIGHT_TO_CHECK_AGAINST == SCREEN_HEIGHT)	{
        device = true
    }
    return device
}

//iPhone 6 OR 6S
func IS_IPHONE_6_OR_6S()->Bool{
    let SCREEN_HEIGHT_TO_CHECK_AGAINST:CGFloat = 667
    var device:Bool = false
    
    if(SCREEN_HEIGHT_TO_CHECK_AGAINST == SCREEN_HEIGHT)	{
        device = true
    }
    return device
}

//iPhone 6Plus OR 6SPlus
func IS_IPHONE_6P_OR_6SP()->Bool{
    let SCREEN_HEIGHT_TO_CHECK_AGAINST:CGFloat = 736
    var device:Bool = false
    
    if(SCREEN_HEIGHT_TO_CHECK_AGAINST == SCREEN_HEIGHT)	{
        device = true
    }
    return device
}
//iPhone X
func IS_IPHONE_X()->Bool{
    let SCREEN_HEIGHT_TO_CHECK_AGAINST:CGFloat = 812
    var device:Bool = false
    
    if(SCREEN_HEIGHT_TO_CHECK_AGAINST == SCREEN_HEIGHT)    {
        device = true
    }
    return device
}
//MARK:- DEVICE ORIENTATION CHECK
func IS_DEVICE_PORTRAIT() -> Bool {
    return UIDevice.current.orientation.isPortrait
}

func IS_DEVICE_LANDSCAPE() -> Bool {
    return UIDevice.current.orientation.isLandscape
}

