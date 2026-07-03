
import UIKit
import LocalAuthentication
import CoreLocation


let YYYY_MM_DD_HH_MM_SS_zzzz = "yyyy-MM-dd HH:mm:ss +zzzz"
let YYYY_MM_DD_HH_MM_SS = "yyyy-MM-dd HH:mm:ss"
let DD_MM_YYYY = "dd-MM-yyyy"
let MM_DD_YYYY = "MM-dd-yyyy"
let MMM_DD_YYYY = "MMM dd,yyyy"

let MM_DD_YYYY_1 = "MM/dd/yyyy"
let YYYY_DD_MM = "yyyy-dd-MM"
let YYYY_MM_DD = "yyyy-MM-dd"
let YYYY_MM_DD_T_HH_MM_SS = "yyyy-MM-dd'T'HH:mm:ss"
let YYYY_MM_DD_T_HH_MM_SSZZ = "yyyy-MM-dd'T'HH:mm:ss'Z'"
let H_MM_A = "h:mm a"

class Constant: NSObject , CLLocationManagerDelegate{
    var locationManager = CLLocationManager()
    static let defaults = UserDefaults.standard
    static var databaseVersion: Int = 1
    static let ErrorMessage = "Error"
    static let Message = "message"


    static let Status = "status"
    static let Data = "data"
    static let Successcode = 1
    static let AlreadyLogin = 400
    static var deviceToken: String = ""
    static var appDelegate = UIApplication.shared.delegate as? AppDelegate
    static let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]

    // MARK: - Nav Colors
    static let greenNavColor = UIColor(hex: 0x01DBA9)
    static let blueNavColor = UIColor(hex: 0x82D0FF)
    static let blackTitleColor = UIColor(hex: 0x313131)
    static let darkBlueNavColor = UIColor(hex: 0x3159D4)
    static let lightBlueNavColor = UIColor(hex: 0x509FE9)
    static let borderGrayColor = UIColor(hex: 0xD0D0D0)

    // MARK: - Border Colors
    static let lightGrayColor: UIColor = UIColor(red: 175.0/255.0, green: 175.0/255.0, blue: 175.0/255.0, alpha: 0.5)

    // MARK: - Button Colors
    static let pinkButtonColor = UIColor(red: 240/255, green: 83/255, blue: 160/255, alpha: 1.0)
    static let greenButtonColor = UIColor(red: 0/255, green: 214/255, blue: 167/255, alpha: 1.0)
    static let readMoreButtonColor = UIColor(red: 74/255, green: 176/255, blue: 218/255, alpha: 1.0)
    
    //MARK:: - Message BakcGrouund Color
    static let senderColor = UIColor(red: 111/255, green: 185/255, blue: 236/255, alpha: 1.0)
    static let receiverColor = UIColor(red: 239/255, green: 239/255, blue: 239/255, alpha: 1.0)
    
    
    static let Themecolor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0)
    
    
    // MARK: - Screen Size
    static var kScreenBounds: CGRect = UIScreen.main.bounds
    static var isiPhone4: Bool = 480 == UIScreen.main.bounds.size.height ? true : false
    static var isiPhone5: Bool = 568 == UIScreen.main.bounds.size.height ? true : false
    static var isiPhone6: Bool = 667 == UIScreen.main.bounds.size.height ? true : false
    static var isiPhone6Plus: Bool = 736 == UIScreen.main.bounds.size.height ? true : false
    static var isiPhoneX: Bool = 812 == UIScreen.main.bounds.size.height ? true : false
    static  let screenSize: CGRect = UIScreen.main.bounds
    
    static var isiPad: Bool = UIDevice.current.userInterfaceIdiom == .pad
    static var isiPhone: Bool = UIDevice.current.userInterfaceIdiom == .phone

    // MARK: - Storyboard File
    static let loginStoryboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
    static let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    static let settingStoryboard: UIStoryboard = UIStoryboard(name: "Setting", bundle: nil)
    static let schoolStoryboard: UIStoryboard = UIStoryboard(name: "SchoolList", bundle: nil)
    static let messageStoryboard: UIStoryboard = UIStoryboard(name: "Message", bundle: nil)
    static let DrawerStoryboard: UIStoryboard = UIStoryboard(name: "Drawer", bundle: nil)
    static let NewRiderStoryboard: UIStoryboard = UIStoryboard(name: "NewRideRequest", bundle: nil)
    static let AcceptRideStoryboard: UIStoryboard = UIStoryboard(name: "AcceptRide", bundle: nil)
    static let DriverRouteStoryboard: UIStoryboard = UIStoryboard(name: "DriverOnRoute", bundle: nil)

    
    
    
    static let dashboardStoryboard: UIStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)

    //Token
    static let strToken: String = ""
    
    static let ownEntityMessage: String = "This is your own entity. Action can not be completed."
    
    static let  GoogleRouteAPIKY: String =  ""
    
    static let GoogleAPIKEY: String = ""
    static let appName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? ""
    static let fontNavBar: UIFont? = UIFont(name: "LucidaGrande-Bold", size: 20.0)
    static let fontLight: String = "LucidaGrande"
    static let fontBold: String = "LucidaGrande-Bold"
    static let fontRegular: String = "LucidaGrande"

//    static let themeColor = UIColor.init(hex: "03a9f4")
    static let searchBGColor = UIColor.init(hex: "E7E7E7")
    
    static let keyWindow = UIApplication.shared.keyWindow!

    // MARK: - Common Alert
    
    static var AppName = "TaxiApp"
    static var NetwrokrError = "Please check your network"
    
    static var ServerError = "Server error"
    
//    static  func setTaskColorHex(code: String) {
//        var  tempString = code as String
//         tempString.remove(at: tempString.startIndex)
//        UserDefaults.standard.set(tempString, forKey: UIColor.black)
//    }
//
//    static func getTaskColorHexString() -> String? {
//        if let color = UserDefaults.standard.string(forKey: UIColor.black
//            return color
//        } else {
//            return nil
//        }
//    }
//
//    //Skill Color
//    static func setSkillColorWithHex(code: String) {
//        var  tempString = code as String
//        tempString.remove(at: tempString.startIndex)
//        UserDefaults.standard.set(tempString, forKey: UIColor.black)
//    }
//
//    static func getSkillColorHexString() -> String? {
//        if let color = UserDefaults.standard.string(forKey: Constant.Themecolor) {
//            return color
//        } else {
//            return nil
//        }
//    }
//    
//    //Favor Color
//    static  func setFavorColorWithHex(code: String) {
//        var  tempString = code as String
//        tempString.remove(at: tempString.startIndex)
//        UserDefaults.standard.set(tempString, forKey: Constant.Themecolor)
//    }
//    static func getFavorColorHexString() -> String? {
//        if let color = UserDefaults.standard.string(forKey: Constant.Themecolor) {
//            return color
//        } else {
//            return nil
//        }
//    }
}

struct CellProperties {
    var cellSpacing: CGFloat = 0.0
    var cellSize: CGSize = CGSize(width: 0, height: 0)
    var numberOfCellsPerRow: CGFloat = 1
    var cellRatio: CGFloat = 1
}

