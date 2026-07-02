
import Foundation


let NoIntenet = "Internet connection appears to be offline."
let ErrorMsg = "Something went wrong. Please try again later"
let StatusCode = "code"
let RequiredData = "data"

//Local
//let BaseUrl = ""

//Staging
let BaseUrl = ""
//let client_id = "e340e7d3ce77625c"

//Staging VMRacks
//let BaseUrl = "https://staging.aonec.com/api/"
//let client_id = "0f0cdc4441e327"

let AppName = ""
let AlertforLogin = "Please login to continue you have already login  in other device!"
let RideRejectMessge = "your ride request has been cancelled by driver please try another taxi!"
let BookAlertMessage = "Thank you! please seat back and relax we are booking your taxi!"
let ErroWhenServerErroOnBooking = "Please try again we are facing some issues"
let DocVerifiedMessage = "Please  verify document to take a ride"
let CarDocVerifiedMessage = "Please  verify car document for give a ride"
let Documentverified = "1"
let CarDocumentverified = "1"
//Live VMRacks
let client_id = ""

let Limit = "20";

let MemberTypes = ["Primary Care","Endocrinology","Nutritionist","Dietitian","Certified Diabetes Educator","Other"]

enum Tags_WherFromType : Int{
    case WhereTo = 0
    case PickupFrom = 1
}
enum Tags_ImageType : String{
    case Carimage  = "1"
    case InsuranceImage = "2"
    case LicenseImage = "3"
}
enum update_ActionType: Int{
    case Rider = 1
    case Driver = 2
}

enum update_Drive_Status: Int{
    case Active = 1
    case Deactive = 0
}
enum update_User_Status: Int{
    case rider = 1
    case Drive = 2
}
enum Tags_WS : String{
    case Email = "email"
    case Pwd = "password"
    case New_Pwd = "new_password"
    case ClientId = "client_id="
    case ClientId1 = "client_id"
    case FirstName = "firstname"
    case LastName = "lastname"
    case BG = "bg"
    case Fasting = "is_fasting"
    case Date = "date"
    case Time = "time"
    case MemberType = "team_member_type"
    case Name = "name"
    case Institution = "institution"
    case Phone = "mobile"
    case Facebookid = "facebook_id"
    case ID = "id"
    case IsUsed = "is_used"
    case IsDeletable = "is_deletable"
    case NewPwd = "newPassword"
    case NewConfimPwd = "newPasswordConfirm"
    case CurrentPwd = "currentPassword"
    case Reset_Pwd_Token = "reset_password_token"
    
    case TimeZone = "timezoneoffset"
    case Device_token  = "device_token"
    case Device_ID = "device_id"
    
    case Device_Type = "device_type"
    case IOS =  "1"
    case Country_ID = "country_id"
    case Country_Code = "code"
    case School_ID = "school_id"
    
    
    case Systolic = "systolic"
    case Date_Time = "date_time"
    case Diastolic = "diastolic"

    enum apiName : String {
        
        case ForgotPassword = "forgot_password?"
        case UserSocial = "user/social_login?"
       
    }
    
    enum Pagination : String {
        
        case Start = "offset"
        case End = "limit"
    }
}

enum  NotificationType : Int {
    case  Newriderequest = 1
    case  Rideoffer = 2
    case  Rideaccepted = 3
    case RideRejeced = 4
    case RideCancelByRider = 5
    
}

enum LocalStoredData : String{
    case isLoggedIn = "isLoggedIn"
    case UserDetail = "isUserDetail"
    case KTouhEnable = "Touchenable"
    case KPasscodeset = "Passcode"
    case KUserPasscode = "UserPasscode"
    case KUserAccessToken = "AccessToken"
    case KisTokenExpire = "isTokenExpire"
    case isUserLoggedIn = "isUserLoggedIn"
}


struct NotificationKeys{
    static let REFRESH_MEDICAL_LIST = "RefreshMedicalList"
    static let REFRESH_MEDICAL_LIST_EDIT = "REFRESH_MEDICAL_LIST_EDIT"
    static let REFRESH_MEDICAL_LIST_DELETE = "REFRESH_MEDICAL_LIST_DELETE"
    
    static let REFRESH_BLOOD_PRESSURE_LIST = "RefreshBLOOD_PRESSUREList"
    static let REFRESH_BLOOD_PRESSURE_LIST_EDIT = "REFRESH_BLOOD_PRESSURE_LIST_EDIT"
    static let REFRESH_BLOOD_PRESSURE_LIST_DELETE = "REFRESH_BLOOD_PRESSURE_LIST_DELETE"

}
struct MyStatuscode {
    static let Statuscode = 401

}

struct MyVariables {
    
    static var FromController = String()
    static var Firstname = String()
    static var LastName = String()
    static var GoogleId = String()
    static var Email = String()
}

enum WS_Status:Int {
    
    case OnGoing = 1
    case Idle = 2
}
