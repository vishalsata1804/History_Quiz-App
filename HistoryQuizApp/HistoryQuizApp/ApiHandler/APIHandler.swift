

import UIKit
import CRNotifications
class APIhandler: NSObject {
    class var sharedInstance: APIhandler
    {
        let SharedInstance: APIhandler = { APIhandler() }()
        return SharedInstance
    }
    //MARK:: Post Request
    func API_GetRequest(Url : String ,completeBlock: @escaping ( _ response: [String : Any]) -> Void, errorBlock: @escaping ( _ error: String) -> Void) {
            let url = URL(string: Url)
            URLSession.shared.dataTask(with: url!, completionHandler: {
                (data, response, error) in
                if(error != nil){
                    errorBlock("Server Not Responding")
                }else{
                    do{
                        let json = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [String : AnyObject]
                        print(json)
                        let response = json as [String : Any]
                        if let code   = response[Constant.Status] as? Int{
                            if code == Constant.AlreadyLogin{
                            }
                        }
                        completeBlock(json as [String : Any])
                    }catch{
                        errorBlock("Please try again")
                    }
                }
            }).resume()
    
    }
    func API_PostRequest(param:[String : Any] ,Url : String ,completeBlock: @escaping ( _ response: [String : Any]) -> Void, errorBlock: @escaping ( _ error: String) -> Void) {
        print(param)
        var dicHeader = [String : String]()
           dicHeader  = [
                "Content-Type": "application/json",
            ]
        guard let postData = try? JSONSerialization.data(withJSONObject: param, options: []) else {
                        return
        }
        var request = URLRequest(url: NSURL(string: Url)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 30.0)

        request.httpMethod = "POST"
        request.allHTTPHeaderFields = dicHeader
        
        request.httpBody = postData
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if(error != nil){
                                errorBlock("Server Not Responding")
                            }else{
                                if let data = data {
                                    do {
                                        if let httpResponse = response as? HTTPURLResponse {
                                            print("error \(httpResponse.statusCode)")
                                        }

                                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                                        print(json)
                                        let response = json as! [String : Any]
                                        if let code   = response[Constant.Status] as? Int{
                                            if code == Constant.AlreadyLogin{
                                            }
                                        }
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

    
    
    //MARK:- API update Profile
    func API_FormData(parameters:[String : Any],image:[UIImage],Url : String ,completeBlock: @escaping ( _ response: [String : Any]) -> Void, errorBlock: @escaping ( _ error: String) -> Void) {
            let myUrl = Url
            
            let url = URL.init(string: myUrl)
            //        let url = URL.init(string: self.baseURL + endPoint.rawValue)
            print("Request URL : \(String(describing: url!.absoluteString))")
            
            
            var request = URLRequest.init(url: url!)
            //            NSMutableURLRequest(url: url!)
            request.httpMethod = "POST"
            
            let boundary = generateBoundaryString()
            
            
            // setting the Content-type and the boundary
            
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            let token: String = "" 
            let authValue: String? = "Bearer \(token)"
            request.setValue(authValue, forHTTPHeaderField: "Authorization")
            request.setValue(Shared.sharedInstance.strDeviceToken, forHTTPHeaderField: "devicetoken")
            
            var body = Data()
            
            for (key, value) in parameters {
                body.append(Data("--\(boundary)\r\n".utf8))
                body.append(Data("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".utf8))
                body.append(Data("\(value)\r\n".utf8))
            }
        
        

        let keys: [String] = ["profile_pic","school_id_card"]
        let filename: [String] = ["Images.jpg","Images1.jpg"]
//        var imageArr : [UIImage] = []
//        for images in image {
//           imageArr.append(images)
//        }
        
        if image.count > 1 {
            for images in image{
                for key in keys{
                    for file in filename {
                        let imageData = images.jpegData(compressionQuality: 1.0)
                        if (imageData != nil) {
                            if let anEncoding = "--\(boundary)\r\n".data(using: .utf8) {
                                body.append(anEncoding)
                            }
                            
                            if let anEncoding = "Content-Disposition: form-data; name=\"\(key)\"; image    [UIImage]    2 values    filename=\"\("\(file)")\"\r\n".data(using: .utf8) {
                                body.append(anEncoding)
                            }
                            
                            if let anEncoding = "Content-Type: image/jpeg\r\n\r\n".data(using: .utf8) {
                                body.append(anEncoding)
                            }
                            body.append(imageData!)
                            if let anEncoding = "\r\n".data(using: .utf8) {
                                body.append(anEncoding)
                            }
                        }
                    }
                    
                }
            }
        }else{
            for images in image{
                let imageData = images.jpegData(compressionQuality: 1.0)
                if (imageData != nil) {
                    if let anEncoding = "--\(boundary)\r\n".data(using: .utf8) {
                        body.append(anEncoding)
                    }
                    
                    if let anEncoding = "Content-Disposition: form-data; name=\"profile_pic\"; filename=\"\("Images.jpg")\"\r\n".data(using: .utf8) {
                        body.append(anEncoding)
                    }
                    
                    if let anEncoding = "Content-Type: image/jpeg\r\n\r\n".data(using: .utf8) {
                        body.append(anEncoding)
                    }
                    body.append(imageData!)
                    if let anEncoding = "\r\n".data(using: .utf8) {
                        body.append(anEncoding)
                    }
                }
            }
        }
        
            
            //  Converted to Swift 4 by Swiftify v4.2.37045 - https://objectivec2swift.com/
            if let anEncoding = "--\(boundary)--\r\n".data(using: .utf8) {
                body.append(anEncoding)
            }
            
            
            // assigning the completed NSMutableData buffer as the body of the HTTP POST request
            request.httpBody = body
            
            _ = OperationQueue()
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
    
}
