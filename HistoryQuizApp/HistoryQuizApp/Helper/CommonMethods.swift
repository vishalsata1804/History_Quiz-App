

import UIKit
//import MBProgressHUD
import CRNotifications
import UserNotifications
import IQKeyboardManagerSwift
import SpinKit

class CommonMethods: NSObject {
    
    // MARK: Variables
    static var sharedObj: Shared?

    static var navControl: UINavigationController?
    
    // MARK: Navigation Methdods
    
    /**
     This methods manage the navigation.
     
     - parameter destinationVC:        destination view controller
     - parameter navigationController: navigation controller object
     - parameter animated:             Animation (true/false)
     */
    
    
    class func setViewBGColorWithShadow(viewNavigation: UIView, bgColor: UIColor) {
        viewNavigation.backgroundColor = bgColor
        viewNavigation.layer.shadowColor = UIColor(white: 0, alpha: 0.4).cgColor
        viewNavigation.layer.shadowRadius = 5.0
        viewNavigation.layer.shadowOpacity = 0.7
        viewNavigation.layer.shadowOffset = CGSize(width: 5, height: 5)
        viewNavigation.layer.masksToBounds = false
        viewNavigation.layer.borderWidth = 0.0
        viewNavigation.layer.borderColor = UIColor.lightGray.cgColor
    }
    

    class func getSymbolForCurrencyCode(code: String) -> String? {
        //let locale = NSLocale(localeIdentifier: code)
        //if locale.displayName(forKey: .currencySymbol, value: code) == code {
        //            let newlocale = NSLocale(localeIdentifier: code.characters.dropLast() + "_en")
        //            let newlocale = NSLocale(localeIdentifier: code + "_en")
        //            return newlocale.displayName(forKey: .currencySymbol, value: code)
        let locale = NSLocale(localeIdentifier: code)
        print(locale.countryCode ?? 0)
        return locale.displayName(forKey: .currencySymbol, value: code)
        //}
        //return locale.displayName(forKey: .currencySymbol, value: code)
    }
    
    class func addTextViewPlaceHolder(textView: UITextView, placeholderLabel: UILabel, placeText: String) {
        // placeholderLabel = UILabel()
        placeholderLabel.text = placeText
        placeholderLabel.font = UIFont(name: Constant.fontRegular, size: (textView.font?.pointSize)!)!//UIFont.italicSystemFont(ofSize: (textView.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        textView.addSubview(placeholderLabel)
        placeholderLabel.frame.origin = CGPoint(x: 0, y: 0)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    class func navigateTo(_ destinationVC: UIViewController, inNavigationViewController navigationController: UINavigationController, animated: Bool ) {
        DispatchQueue.main.async(execute: {
            navigationController.pushViewController(destinationVC, animated: animated)
        })
    }
    
    class func presentTo(_ destinationVC: UIViewController, inNavigationViewController navigationController: UINavigationController, animated: Bool ) {
        DispatchQueue.main.async(execute: {
            navigationController.present(destinationVC, animated: true, completion: nil)
        })
    }
    
    class func convertBase64ToImage(base64: String) -> UIImage {
        var image = UIImage()
        DispatchQueue.main.async(execute: {
            if let decodedData = Data(base64Encoded: base64, options: .ignoreUnknownCharacters) {
                return image = UIImage(data: decodedData)!
            }
        })
        return image
    }
    
    class func addSpinner(view : UIView,color : UIColor = Color.ThemeColor.value){
        removeSpinner(view: view)
        let spinner = RTSpinKitView(style: .styleWanderingCubes, color: color)
//        let spinner = RTSpinKitView(style: .styleBounce, color: color)
        spinner?.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
        spinner?.tag = 212;
        view.addSubview(spinner!)
        spinner?.backgroundColor = UIColor.clear
        view.isUserInteractionEnabled = false;
        spinner?.startAnimating()
    }
    class  func showAlertinfo(mseesage : String  , issuccess: Bool){
        CRNotifications.showNotification(type: issuccess ? CRNotifications.success :CRNotifications.error , title: AppName, message: mseesage, dismissDelay: 0.0)
    }
    class  func removeSpinner(view : UIView){
//    DispatchQueue.main.async {
        view.isUserInteractionEnabled = true;
        view.viewWithTag(212)?.removeFromSuperview()
        view.viewWithTag(213)?.removeFromSuperview()
//    }
    }
    /**
     This methods is used to get reference of already present viewcontroller object.
     
     - parameter destinationVC:        destination view controller
     - parameter navigationController: navigation controller object
     
     - returns: Object of destination view controller
     */
    class func findViewControllerRefInStack(_ destinationVC: UIViewController, inNavigationViewController navigationController: UINavigationController) -> UIViewController {
        var VCFound = false
        var viewControllers = navigationController.viewControllers
        var indexofVC = 0
        for vc: UIViewController in viewControllers {
            if vc.nibName == (destinationVC.nibName) {
                VCFound = true
                break
            } else {
                indexofVC += 1
            }
        }
        if VCFound == true {
            return viewControllers[indexofVC]
        } else {
            return destinationVC
        }
    }
   
    class func navigatePopViewController(animated: Bool ) {
        DispatchQueue.main.async(execute: {
            self.navControl?.popViewController(animated: animated)
        })
    }
    
    /**
     Setting Up UI of navigation Bar
     
     - parameter navControl:  Object of Navigation Controller
     - parameter navItem: Object of Navigation Item
     - parameter title:   Title of Navigation Bar
     */
    
    class func currentTime() -> String {
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        return "\(hour):\(minutes):\(seconds)"
    }
    class func setUpNavigationBar(_ navControl: UINavigationController, viewcontroller: UIViewController, navItem: UINavigationItem, title: NSString, transperant isTrans: Bool, hidden isHidden: Bool, barColor: UIColor, fontColor: UIColor, barStyle: UIStatusBarStyle = .default) {
        
        UIApplication.shared.statusBarStyle = barStyle
        if  !isHidden {
            navControl.navigationBar.isHidden = false
            let Fontcolor: UIColor = fontColor
            if isTrans {
                navControl.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
                navControl.navigationBar.shadowImage = UIImage()
                navControl.navigationBar.isTranslucent = true
                navControl.view.backgroundColor = UIColor.clear
            } else {
                navControl.view.backgroundColor = barColor
                navControl.navigationBar.isTranslucent = isTrans
                navControl.navigationBar.barTintColor = barColor
                CommonMethods.setViewBGColorWithShadow(viewNavigation: navControl.navigationBar, bgColor: Constant.Themecolor)
            }
            viewcontroller.navigationItem.title = title as String
//            navControl.navigationBar.tintColor = Fontcolor
            navControl.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.init(name: Font.FontName.Quicksand_Medium.rawValue, size: 22) ?? 20, NSAttributedString.Key.foregroundColor: Fontcolor]

        } else {
            navControl.navigationBar.isHidden = true
        }
    }
    class func setUpNavigationBar2(_ navControl: UINavigationController, viewcontroller: UIViewController, navItem: UINavigationItem, title: NSString, transperant isTrans: Bool, hidden isHidden: Bool, barColor: UIColor, fontColor: UIColor, barStyle: UIStatusBarStyle = .default) {
        
        UIApplication.shared.statusBarStyle = barStyle
        if  !isHidden {
            navControl.navigationBar.isHidden = false
            let Fontcolor: UIColor = fontColor
            if isTrans {
                navControl.navigationBar.isTranslucent = isTrans
                navControl.navigationBar.barTintColor = barColor
                navControl.navigationBar.shadowImage = UIImage()
            } else {
                navControl.view.backgroundColor = barColor
                navControl.navigationBar.isTranslucent = isTrans
                navControl.navigationBar.barTintColor = barColor
            }
            viewcontroller.navigationItem.title = title as String
            navControl.navigationBar.tintColor = UIColor.white
            navControl.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.init(name: Font.FontName.Quicksand_Medium.rawValue, size: 22), NSAttributedString.Key.foregroundColor: Fontcolor]
            
        } else {
            navControl.navigationBar.isHidden = true
        }
    }
    
    class func setUpNavigationBarWithoutShadow(_ navControl: UINavigationController, viewcontroller: UIViewController, navItem: UINavigationItem, title: NSString, transperant isTrans: Bool, hidden isHidden: Bool, barColor: UIColor, fontColor: UIColor, barStyle: UIStatusBarStyle = .default) {
        
        UIApplication.shared.statusBarStyle = barStyle
        if  !isHidden {
            navControl.navigationBar.isHidden = false
            let Fontcolor: UIColor = fontColor
            if isTrans {
                navControl.navigationBar.isTranslucent = isTrans
                navControl.navigationBar.barTintColor = barColor
                navControl.navigationBar.shadowImage = UIImage()
            } else {
                navControl.view.backgroundColor = barColor
                navControl.navigationBar.isTranslucent = isTrans
                navControl.navigationBar.barTintColor = barColor
            }
            viewcontroller.navigationItem.title = title as String
            navControl.navigationBar.tintColor = UIColor.white
            navControl.navigationBar.titleTextAttributes = [ NSAttributedString.Key.font: UIFont.init(name: Font.FontName.Quicksand_Medium.rawValue, size: 22), NSAttributedString.Key.foregroundColor: Fontcolor]
            CommonMethods.setViewBGColorWithoutShadowRemoved(viewNavigation: navControl.navigationBar, shadowColor: UIColor.clear)
        } else {
            navControl.navigationBar.isHidden = true
        }
    }
    
   class func setViewBGColorWithoutShadowRemoved(viewNavigation: UIView, shadowColor: UIColor) {
        viewNavigation.layer.shadowColor = shadowColor.cgColor
        viewNavigation.layer.shadowRadius = 5.0
        viewNavigation.layer.shadowOpacity = 0.7
        viewNavigation.layer.shadowOffset = CGSize(width: 5, height: 5)
        viewNavigation.layer.masksToBounds = false
    }    
    class func timeleft(date: Date) -> String {
        let now = NSDate()
        let dayHourMinuteSecond: Set<Calendar.Component> = [.day, .hour, .minute, .second]
        let difference = NSCalendar.current.dateComponents(dayHourMinuteSecond, from: now as Date, to: date as Date)
        
        let seconds = "In"+" \(difference.second ?? 0) second"
        let minutes = "In"+" \(difference.minute ?? 0) minute"
        let hours = "In"+" \(difference.hour ?? 0) hours"
        let days =  "In"+" \(difference.day ?? 0) day"
        
        if let day = difference.day, day > 0 { return days } else if let hour = difference.hour, hour > 0 { return hours } else if let minute = difference.minute, minute > 0 { return minutes } else if let second = difference.second, second > 0 { return seconds }
        return ""
    }
    
    // MARK: Validation Methods
    class func emailAdrressValidation(strEmail: String) -> Bool {
        if strEmail.isEmpty {
            return false
        }
        let emailRegEx = "[.0-9a-zA-Z_-]+@[0-9a-zA-Z.-]+\\.[a-zA-Z]{2,20}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        if !emailTest.evaluate(with: strEmail) {
            return false
        }
        return true
    }
    
    // MARK: Cursor Position Method
    class func setCursorPosition(input: UITextField, position: Int, placeHolder: String, placeHolderColor: UIColor) {
        input.leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: position, height: 0))//UIView(frame: CGRect(0, 0, 8, 0));
        input.leftViewMode = .always
        input.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor: placeHolderColor])
    }
    
    // MARK: Cursor Position Method
    class func setTextFieldBorderColor(input: UITextField, borderColor: UIColor) {
        input.layer.cornerRadius = 5.0
        input.layer.borderColor = borderColor.cgColor
        input.layer.borderWidth = 1.0
        input.layer.masksToBounds = true
    }
    
    class func setViewBorderColor(input: UIView, borderColor: UIColor) {
        input.layer.cornerRadius = 5.0
        input.layer.borderColor = borderColor.cgColor
        input.layer.borderWidth = 1.0
        input.layer.masksToBounds = true
    }
    
    class func setButtonBorderColor(input: UIButton, borderColor: UIColor) {
        input.layer.cornerRadius = 5.0
        input.layer.borderColor = borderColor.cgColor
        input.layer.borderWidth = 1.0
        input.layer.masksToBounds = true
    }
    class func getCellPropertiesWith(referenceWidth: CGFloat, numberOfCellsPerRow: Int, cellSpacing: CGFloat, cellRatio ratio: CGFloat) -> CellProperties {
        var cellWidth = (referenceWidth - ((CGFloat(numberOfCellsPerRow) - 1) * cellSpacing)) / CGFloat(numberOfCellsPerRow)
        cellWidth = CGFloat(Int(cellWidth))
        let cellHeight = cellWidth / ratio
        let cellSize = CGSize(width: cellWidth, height: cellHeight)
        return CellProperties(cellSpacing: cellSpacing, cellSize: cellSize, numberOfCellsPerRow: CGFloat(numberOfCellsPerRow), cellRatio: ratio)
    }
    class func validatePhone(value: String) -> Bool {
        let PHONE_REGEX = "^\\d{3}-\\d{3}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: value)
        return result
    }
    
    class func convertDateFormat(strDate: String) -> String {
        let arrDate: [String] = strDate.components(separatedBy: ".")
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd-MMM-yyyy"
        
        let date: NSDate? = dateFormatterGet.date(from: arrDate[0]) as NSDate?
        //print(dateFormatterPrint.string(from: date! as Date))
        return dateFormatterPrint.string(from: date! as Date)
    }
    class func convertDateFormatWithFormat(strDate: String, format: String) -> String {
        let arrDate: [String] = strDate.components(separatedBy: ".")
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = format
        
        let date: NSDate? = dateFormatterGet.date(from: arrDate[0]) as NSDate?
        //print(dateFormatterPrint.string(from: date! as Date))
        return dateFormatterPrint.string(from: date! as Date)
    }
    class func convertStringToDateFormat(strDate: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd-MMM-yyyy"
        
        let date: NSDate? = dateFormatterGet.date(from: strDate)! as NSDate
        print(dateFormatterPrint.string(from: date! as Date))
        return dateFormatterPrint.string(from: date! as Date)
    }
    class func convertDateFormatForQuickRegistration(strDate: String) -> String {
        //        let arrDate: [String] = strDate.components(separatedBy: ".")
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "dd/MM/yyyy"
        //
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        
        let date: NSDate? = dateFormatterGet.date(from: strDate)! as NSDate
        print(dateFormatterPrint.string(from: date! as Date))
        return dateFormatterPrint.string(from: date! as Date)
    }
    class func currentDate() -> String {
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd/MM/yyyy"
        
        let date = Date()
        //print(dateFormatterPrint.string(from: date as Date))
        return dateFormatterPrint.string(from: date as Date)
    }
   class func authLocation()  {
        if Shared.sharedInstance.checkLoactionService().0{
            Shared.sharedInstance.getCurrentLocation()
        }else{
            CRNotifications.showNotification(type: CRNotifications.error, title: AppName, message: Shared.sharedInstance.checkLoactionService().1, dismissDelay: 2.0)
        }
    }
    class func convertImageToBase64(image: UIImage) -> String {
        
        let imageData = image.pngData()
        return (imageData?.base64EncodedString(options: .lineLength64Characters))!
    }
    class func encodeString(url : String)  -> String{
//        let escapedString = url.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let urlNew:String = url.replacingOccurrences(of: " ", with: "%20").trim()
        return urlNew
    }
    
    //MARK:- Add Driver Latitude into  Firebase Database
    class func calToUser (Mobile : String)
    {
        if let url = URL(string: "tel://\(Mobile)"),
            UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler:nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            // add error message here
        }
    }
    class func API_UserStatus(postParama : [String : Any] , strUrl:String , completeBlock: @escaping ( _ response: [String : Any]) -> Void, errorBlock: @escaping ( _ error: String) -> Void)  {
        APIhandler.sharedInstance.API_PostRequest(param:postParama,Url: strUrl, completeBlock: { ( responseObject) in
                if responseObject[Constant.Status] as! Int == Constant.Successcode{
                    completeBlock(responseObject as [String : Any])
                }else{
                    errorBlock("Please try again")
                }
            }) { ( error) in
                //show error alert
                errorBlock("Please try again")

            }
    }
    
    // MARK: - Custum Functions
    class func setupNotification(_ application: UIApplication) {
        // iOS 12 support
        if #available(iOS 12, *) {
            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound, .provisional, .providesAppNotificationSettings, .criticalAlert]){ (granted, error) in }
            application.registerForRemoteNotifications()
        }
        
        // iOS 10 support
        if #available(iOS 10, *) {
            UNUserNotificationCenter.current().requestAuthorization(options:[.badge, .alert, .sound]){ (granted, error) in }
            application.registerForRemoteNotifications()
        }
            // iOS 9 support
        else if #available(iOS 9, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
            // iOS 8 support
        else if #available(iOS 8, *) {
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.badge, .sound, .alert], categories: nil))
            UIApplication.shared.registerForRemoteNotifications()
        }
            // iOS 7 support
        else {
            application.registerForRemoteNotifications(matching: [.badge, .sound, .alert])
        }
        
    }
    
    class func compressImage(image: UIImage) -> Data {
        // Reducing file size to a 10th
        
        var actualHeight: CGFloat = image.size.height
        var actualWidth: CGFloat = image.size.width
        let maxHeight: CGFloat = 1136.0
        let maxWidth: CGFloat = 640.0
        var imgRatio: CGFloat = actualWidth/actualHeight
        let maxRatio: CGFloat = maxWidth/maxHeight
        var compressionQuality: CGFloat = 0.5
        
        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                //                actualWidth = imgRatio * actualWidth
                actualWidth = round(imgRatio * actualWidth)
                actualHeight = maxHeight
            } else if imgRatio > maxRatio {
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = round(imgRatio * actualHeight)
                actualWidth = maxWidth
            } else {
                actualHeight = maxHeight
                actualWidth = maxWidth
                compressionQuality = 1
            }
        }
        let rect = CGRect(x: 0.0, y: 0.0, width: floor(actualWidth), height: floor(actualHeight))
        print(rect)
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        
        guard let img = UIGraphicsGetImageFromCurrentImageContext() else {
            return Data()
        }
        UIGraphicsEndImageContext()
        
        let imageData = img.jpegData(compressionQuality: compressionQuality)

        
//        guard let imageData = UIImageJPEGRepresentation(img, compressionQuality) else {
//            return Data()
//        }
        return imageData!
    }
    
    
   
    class func setSubScriptFont(baseText: String, subText: String, fontColor: UIColor, subTextColor: UIColor, fontSize: Float ) -> NSAttributedString {
        let finalText = baseText + subText
        let font: UIFont? = UIFont(name: "Raleway-Bold", size: CGFloat(fontSize))
        let attString: NSMutableAttributedString = NSMutableAttributedString(string: finalText, attributes: [NSAttributedString.Key.font: font!, NSAttributedString.Key.foregroundColor: fontColor])
        attString.setAttributes([NSAttributedString.Key.font: font!, NSAttributedString.Key.baselineOffset: 0, NSAttributedString.Key.foregroundColor: subTextColor], range: NSRange(location: baseText.count, length: subText.count))
        return attString
    }
    
    class func getFirstNameFrom(FullName fullName: String) -> String {
        return fullName.components(separatedBy: " ").first!
    }
    
    class func getCountryPhonceCode(country: String) -> String {
        
        if country.count == 2 {
            let x: [String] = ["972", "IL",
                               "93", "AF",
                               "355", "AL",
                               "213", "DZ",
                               "1", "AS",
                               "376", "AD",
                               "244", "AO",
                               "1", "AI",
                               "1", "AG",
                               "54", "AR",
                               "374", "AM",
                               "297", "AW",
                               "61", "AU",
                               "43", "AT",
                               "994", "AZ",
                               "1", "BS",
                               "973", "BH",
                               "880", "BD",
                               "1", "BB",
                               "375", "BY",
                               "32", "BE",
                               "501", "BZ",
                               "229", "BJ",
                               "1", "BM",
                               "975", "BT",
                               "387", "BA",
                               "267", "BW",
                               "55", "BR",
                               "246", "IO",
                               "359", "BG",
                               "226", "BF",
                               "257", "BI",
                               "855", "KH",
                               "237", "CM",
                               "1", "CA",
                               "238", "CV",
                               "345", "KY",
                               "236", "CF",
                               "235", "TD",
                               "56", "CL",
                               "86", "CN",
                               "61", "CX",
                               "57", "CO",
                               "269", "KM",
                               "242", "CG",
                               "682", "CK",
                               "506", "CR",
                               "385", "HR",
                               "53", "CU",
                               "537", "CY",
                               "420", "CZ",
                               "45", "DK",
                               "253", "DJ",
                               "1", "DM",
                               "1", "DO",
                               "593", "EC",
                               "20", "EG",
                               "503", "SV",
                               "240", "GQ",
                               "291", "ER",
                               "372", "EE",
                               "251", "ET",
                               "298", "FO",
                               "679", "FJ",
                               "358", "FI",
                               "33", "FR",
                               "594", "GF",
                               "689", "PF",
                               "241", "GA",
                               "220", "GM",
                               "995", "GE",
                               "49", "DE",
                               "233", "GH",
                               "350", "GI",
                               "30", "GR",
                               "299", "GL",
                               "1", "GD",
                               "590", "GP",
                               "1", "GU",
                               "502", "GT",
                               "224", "GN",
                               "245", "GW",
                               "595", "GY",
                               "509", "HT",
                               "504", "HN",
                               "36", "HU",
                               "354", "IS",
                               "91", "IN",
                               "62", "ID",
                               "964", "IQ",
                               "353", "IE",
                               "972", "IL",
                               "39", "IT",
                               "1", "JM",
                               "81", "JP", "962", "JO", "77", "KZ",
                               "254", "KE", "686", "KI", "965", "KW", "996", "KG",
                               "371", "LV", "961", "LB", "266", "LS", "231", "LR",
                               "423", "LI", "370", "LT", "352", "LU", "261", "MG",
                               "265", "MW", "60", "MY", "960", "MV", "223", "ML",
                               "356", "MT", "692", "MH", "596", "MQ", "222", "MR",
                               "230", "MU", "262", "YT", "52", "MX", "377", "MC",
                               "976", "MN", "382", "ME", "1", "MS", "212", "MA",
                               "95", "MM", "264", "NA", "674", "NR", "977", "NP",
                               "31", "NL", "599", "AN", "687", "NC", "64", "NZ",
                               "505", "NI", "227", "NE", "234", "NG", "683", "NU",
                               "672", "NF", "1", "MP", "47", "NO", "968", "OM",
                               "92", "PK", "680", "PW", "507", "PA", "675", "PG",
                               "595", "PY", "51", "PE", "63", "PH", "48", "PL",
                               "351", "PT", "1", "PR", "974", "QA", "40", "RO",
                               "250", "RW", "685", "WS", "378", "SM", "966", "SA",
                               "221", "SN", "381", "RS", "248", "SC", "232", "SL",
                               "65", "SG", "421", "SK", "386", "SI", "677", "SB",
                               "27", "ZA", "500", "GS", "34", "ES", "94", "LK",
                               "249", "SD", "597", "SR", "268", "SZ", "46", "SE",
                               "41", "CH", "992", "TJ", "66", "TH", "228", "TG",
                               "690", "TK", "676", "TO", "1", "TT", "216", "TN",
                               "90", "TR", "993", "TM", "1", "TC", "688", "TV",
                               "256", "UG", "380", "UA", "971", "AE", "44", "GB",
                               "1", "US", "598", "UY", "998", "UZ", "678", "VU",
                               "681", "WF", "967", "YE", "260", "ZM", "263", "ZW",
                               "591", "BO", "673", "BN", "61", "CC", "243", "CD",
                               "225", "CI", "500", "FK", "44", "GG", "379", "VA",
                               "852", "HK", "98", "IR", "44", "IM", "44", "JE",
                               "850", "KP", "82", "KR", "856", "LA", "218", "LY",
                               "853", "MO", "389", "MK", "691", "FM", "373", "MD",
                               "258", "MZ", "970", "PS", "872", "PN", "262", "RE",
                               "7", "RU", "590", "BL", "290", "SH", "1", "KN",
                               "1", "LC", "590", "MF", "508", "PM", "1", "VC",
                               "239", "ST", "252", "SO", "47", "SJ",
                               "963", "SY",
                               "886",
                               "TW", "255",
                               "TZ", "670",
                               "TL", "58",
                               "VE", "84",
                               "VN",
                               "284", "VG",
                               "340", "VI",
                               "678", "VU",
                               "681", "WF",
                               "685", "WS",
                               "967", "YE",
                               "262", "YT",
                               "27", "ZA",
                               "260", "ZM",
                               "263", "ZW"]
            var keys = [String]()
            var values = [String]()
            let whitespace = NSCharacterSet.decimalDigits
            
            //let range = phrase.rangeOfCharacterFromSet(whitespace)
            for i in x {
                // range will be nil if no whitespace is found
                if i.rangeOfCharacter(from: whitespace) != nil {
                    values.append(i)
                } else {
                    keys.append(i)
                }
            }
            
            let countryCodeListDict = NSDictionary(objects: values as [String], forKeys: keys as [String] as [NSCopying])
            if countryCodeListDict.value(forKey: country) != nil {
                return countryCodeListDict.value(forKey: country) as! String
            } else {
                return ""
            }
        } else {
            return ""
        }
    }
}
