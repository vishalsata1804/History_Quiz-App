
import Foundation
import CoreLocation
import UserNotifications
import UIKit
import CRNotifications
@objc protocol LocationDelegate {
    func currentLocation(latitude: Double, longitude: Double)
}

class Shared: NSObject, CLLocationManagerDelegate {
    var latitude: Double = 0
    var longtitude: Double = 0
    var errorMessage = ""
    var locationManager = CLLocationManager()
    weak var delegate: LocationDelegate?
    var locationName: String?
    var strDropAddress  : String?
    var strDropAddressLat : String?
    var strDropAddressLong : String?
    var strDeviceToken = "fgnfdijgdifjgiudfjigiudfgiuhhuuyb"
    var addressStr: String = ""
    var isUserGet : Bool = false
    var RiderSelectedWheretoLatitude  = 0.00
    var RiderSelectedWheretoLongitude  = 0.00
    var RiderSelectedWheretoAddress = ""
    
    var RiderSelectedFromtoLatitude  = 0.00
    var RiderSelectedFromtoLongitude  = 0.00
    var RiderSelectedFromtoAddress = ""
    var isDrive =  -1
    var isDriverActive = false
    var strCurrentDataTime = ""
    
    
//    var userDetail: UserDetail? {
//        didSet {
//            if userDetail != nil {
//                isGuestUser = false
//            } else {
//                isGuestUser = true
//            }
//        }
//    }
    // MARK: - Init
    fileprivate override init() {
        
        super.init()
        self.locationManager = CLLocationManager()

    }
    
    class var sharedInstance: Shared {
        struct Static {
            static var instance: Shared?
            static var token: Int = 0
        }
        if Static.instance == nil {
            Static.instance = Shared()
        }
        return Static.instance!
    }
    func CurrunrDate()  {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let result = formatter.string(from: date)
        strCurrentDataTime = result
    }
    
    func checkLoactionService() -> (Bool ,String)
    {
        var isLocationOn = Bool()
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined, .restricted, .denied:
                isLocationOn = false
                errorMessage = "Please give acesss to" +  AppName +  "for current location"
            case .authorizedAlways, .authorizedWhenInUse:
                print("Access")
                errorMessage = "Success"
                isLocationOn = true
                
                self.getCurrentLocation()
            }
        } else {
            errorMessage = "Please turn on your location"
            isLocationOn = false
        }
        return (isLocationOn , errorMessage)
    }
    
    func API_FormDataPostRequest(param:[String : Any] ,Url : String ,completeBlock: @escaping ( _ response: [String : Any]) -> Void, errorBlock: @escaping ( _ error: String) -> Void) {
        let param: [String:Any] = param
        
        let myUrl = Url
        
        let request = NSMutableURLRequest(url: URL.init(string: myUrl)!)
        request.httpMethod = "POST";
        
        let boundary = generateBoundaryString()
        
        let authValue = "Bearer"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.setValue(authValue, forHTTPHeaderField: "Authorization")
        request.setValue(Shared.sharedInstance.strDeviceToken, forHTTPHeaderField: "devicetoken")
        
        let imageData = Data()
        
        request.httpBody = createBodyWithParameters(parameters: param as? [String : String], filePathKey: "file", imageDataKey: imageData as NSData, boundary: boundary) as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if(error != nil){
                errorBlock("Server Not Responding")
            }else{
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print(json)
                        completeBlock(json as! [String : Any])
                        
                    }catch {
                        print(error)
                        errorBlock("Please try again")
                    }
                }
            }
            
        })
        dataTask.resume()
    }
    
    func generateBoundaryString() -> String
    {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.append("--\(boundary)\r\n".data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
                body.append("\(value)\r\n".data(using: .utf8)!)
            }
        }
        
        let filename = "user-profile.jpg"
        let mimetype = "image/jpg"
        
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: \(mimetype)\r\n\r\n".data(using: .utf8)!)
        body.append(imageDataKey as Data)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        return body
    }
    
    
    // MARK: - Current Location
    func getCurrentLocation() {
            CurrunrDate()
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            //            locationManager.distanceFilter = 100
            locationManager.delegate = self
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if manager.location != nil {
            let locValue: CLLocationCoordinate2D = manager.location!.coordinate
            latitude = locValue.latitude
            longtitude = locValue.longitude
//
            latitude = 22.9798
            longtitude = 72.4927
            
            let location = CLLocation(latitude: latitude, longitude: longtitude) //changed!!!
            CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
                if error != nil {
                    return
                }
                if placemarks != nil
                {
                    let pm = placemarks! as [CLPlacemark]
                    if pm.count > 0 {
                        let pm = placemarks![0]
                        print(pm.country ?? "")
                        print(pm.locality ?? "")
                        print(pm.subLocality ?? "")
                        print(pm.thoroughfare ?? "")
                        print(pm.postalCode ?? "")
                        print(pm.subThoroughfare ?? "")
                        var addressString : String = ""
                        if pm.subLocality != nil {
                            addressString = addressString + pm.subLocality! + ", "
                        }
                        if pm.thoroughfare != nil {
                            addressString = addressString + pm.thoroughfare! + ", "
                        }
                        if pm.locality != nil {
                            addressString = addressString + pm.locality! + ", "
                            if pm.country != nil {
                                addressString = addressString + pm.country! + ", "
                            }
                        }
                        if pm.postalCode != nil {
                            addressString = addressString + pm.postalCode! + " "
                            print(addressString)
                            Shared.sharedInstance.addressStr = addressString
                        }
                    }
                }
            })
            if let delegate = delegate {
                delegate.currentLocation(latitude: locValue.latitude, longitude: locValue.longitude)
            }
        }
    }
    
    func triggerNotification(distance: Double, title: String) {
        print("notification will be triggered in five seconds..Hold on tight")
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = String(distance)
        content.body = "Sample code from WWDC"
        content.sound = UNNotificationSound.default
        // Deliver the notification in five seconds.
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 4.0, repeats: false)
        let request = UNNotificationRequest(identifier: "FiveSecond", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request) {(error) in
            if (error != nil) {
                print(error?.localizedDescription ?? "")
            }
        }
    }
    
    func fetchCountryAndCity(location: CLLocation, completion: @escaping (String, String) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print(error)
            } else if let country = placemarks?.first?.country,
                let city = placemarks?.first?.locality {
                completion(country, city)
                self.locationName = placemarks![0].name! + "  " + city + " " + country
                
            }
        }
    }
    class func setBadgeIndicator(badgeCount: Int) {
        let application = UIApplication.shared
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.badge, .alert, .sound]) { _, _ in }
        } else {
            application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil))
        }
        application.registerForRemoteNotifications()
        application.applicationIconBadgeNumber = badgeCount
    }
}
