

import UIKit

// MARK:- SINGLETON classes

//let APPDELEGATE = (UIApplication.shared.delegate as! AppDelegate)
//let DBSINGLETON : DBSingleton = DBSingleton.sharedInstance

// MARK:- SCREEN SIZE
struct ScreenSize
{
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}
// MARK:- DEVICE TYPE
struct DeviceType
{
    static let IS_IPHONE_4_OR_LESS  = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH < 568.0
    static let IS_IPHONE_5          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6          = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6_PLUS     = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPAD              = UIDevice.current.userInterfaceIdiom == .pad
}

//MARK: DB NAME JM
func getDataBaseName()->String
{
    return "AppDBName.sqlite"
}

// MARK: Set object in NSuserDefault :-
func kNSuserDefault(_ value:AnyObject, key:NSString){
    UserDefaults.standard.set(value, forKey: key as String )
    UserDefaults.standard.synchronize()
}

//func kNSUserDefaultPasscode()  {
//    if let chekpasscodeset = UserDefaults.standard.value(forKey: LocalStoredData.KPasscodeset.rawValue) as? Bool
//    {
//        if chekpasscodeset == true
//        {
//            UserDefaults.standard.set(true, forKey: LocalStoredData.KPasscodeset.rawValue)
//
//            if let chekTouchId = UserDefaults.standard.value(forKey: LocalStoredData.KTouhEnable.rawValue) as? Bool
//            {
//                if chekTouchId == true
//                {
//                    UserDefaults.standard.set(true, forKey: LocalStoredData.KTouhEnable.rawValue)
//
//                }
//                else{
//                    UserDefaults.standard.set(false, forKey: LocalStoredData.KTouhEnable.rawValue)
//                }
//            }
//            else{
//                UserDefaults.standard.set(false, forKey: LocalStoredData.KTouhEnable.rawValue)
//            }
//
//
//        }
//        else{
//            UserDefaults.standard.set("", forKey: LocalStoredData.KUserPasscode.rawValue)
//            UserDefaults.standard.set(false, forKey: LocalStoredData.KPasscodeset.rawValue)
//            UserDefaults.standard.set(false, forKey: LocalStoredData.KTouhEnable.rawValue)
//
//        }
//    }
//    else
//    {
//        UserDefaults.standard.set("", forKey: LocalStoredData.KUserPasscode.rawValue)
//        UserDefaults.standard.set(false, forKey: LocalStoredData.KPasscodeset.rawValue)
//        UserDefaults.standard.set(false, forKey: LocalStoredData.KTouhEnable.rawValue)
//    }
//}

func kNSUserDefaultGetValue(_ key:String?)->AnyObject?{
    return UserDefaults.standard.value(forKey: key!) as AnyObject?
    
}

func kNSUserDefaultRemoveValueForkey(_ key:String?){
    UserDefaults.standard.removeObject(forKey: key!)
    UserDefaults.standard.synchronize()
}

//MARK: - Read Localozed File
func read_Localizable(_ title:String)->String{
    return  NSLocalizedString(title, comment: "")
}


// For WhiteSpace
func removeWhiteSpace(_ string : String) -> String
{
    return string.trimmingCharacters(in: CharacterSet.whitespaces)
}

func getDocumentDirectory() -> String {
    let paths: [Any] = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let documentsDirectory: String? = (paths[0] as? String)
    return documentsDirectory!
}


func applyTheme(btn:UIButton){

//    btn.TWBorderColor = Color.custom(hexString: "#D7D7D7", alpha: 1.0).value
//    btn.BorderWidth = 0.5
//    btn.Corneredius = 3.0
//    btn.titleLabel?.font = UIFont.init(name: Font.FontName.OpenSans_Light.rawValue, size: 19)
//    btn.titleLabel?.textColor = Color.custom(hexString: "FFFFFF", alpha: 1.0).value

}


func addSpinner(view : UIView,color : UIColor = Color.White.value){
    
    removeSpinner(view: view)
//    let spinner = RTSpinKitView(style: .style9CubeGrid, color: color)
//    spinner?.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
//    spinner?.tag = 212;
//    view.addSubview(spinner!)
//    spinner?.backgroundColor = Color.ThemeColor.value.withAlphaComponent(0.7)
    
    
    let spinner = UIActivityIndicatorView(style: .whiteLarge)
    spinner.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
    spinner.color = UIColor.gray
    spinner.tag = 212;
    view.addSubview(spinner)
    view.isUserInteractionEnabled = false;
    spinner.startAnimating()

}

func removeSpinner(view : UIView){
    view.isUserInteractionEnabled = true;
    view.viewWithTag(212)?.removeFromSuperview()
    view.viewWithTag(213)?.removeFromSuperview()
}

func handleError(errorDict : NSDictionary?){
//    if let message = errorDict?.value(forKeyPath: "error.message") as? String{
//        CRNotifications.showNotification(type: .success, title: "", message:message , dismissDelay: 3)
//    }else{
//        CRNotifications.showNotification(type: .success, title: "", message:ErrorMsg , dismissDelay: 3)
//    }
}

func removeSpinnerOnSubView(view : UIView){
    view.viewWithTag(213)?.removeFromSuperview()
}
func addSpinnerObSubView(view : UIView,color : UIColor = Color.White.value){
    
    removeSpinner(view: view)
    
//    let spinner = RTSpinKitView(style: .style9CubeGrid, color: color)
//    spinner?.center = CGPoint(x: view.frame.size.width / 2, y: view.frame.size.height / 2)
//    spinner?.tag = 213;
//    view.addSubview(spinner!)
//    spinner?.backgroundColor = Color.ThemeColor.value.withAlphaComponent(0.7)
    
    let spinner = UIActivityIndicatorView(style: .whiteLarge)
    spinner.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)
    spinner.color = UIColor.black
    spinner.tag = 213;
    view.addSubview(spinner)
    view.isUserInteractionEnabled = false;
    spinner.startAnimating()
}


let kPrimaryOrange = UIColor(hexString: "D23200")
let kLightGrey = UIColor(hexString: "F2F2F2")
let kMediumGrey = UIColor(hexString: "989898")
let kDarkerGrey = UIColor(hexString: "565656")
let kHealthyGreen = UIColor(hexString: "92D050")
let kWarningOrange = UIColor(hexString: "FFC000")
let kAccentBlue = UIColor(hexString: "37CBFF")
let kFacebookBlue = UIColor(hexString: "3b5998")
let kGoogleBlue = UIColor(hexString: "0266C8")
let kLinkedInBlue = UIColor(hexString: "0077B5")


let maxRequiredWidth = CGFloat(550.0);

