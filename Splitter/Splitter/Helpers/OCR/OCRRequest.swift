//
//  OCRRequest.swift
//  Splitter
//
//  Created by Wayne Rumble on 28/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//
import UIKit
import AFNetworking

class OCRRequest {
    
    var urlExtension = "extractText"
    
    func uploadReceiptImage(image: String) {
        let params = ["image": image] as [String: Any]
        HttpRequest().post(params: params,
                           URLExtension: urlExtension,
                           success: { response in print(response)},
                           fail: { response in print(response)})
//        HttpRequest().postWithImageData(params: params,
//                                        URLExtension: urlExtension,
//                                        imageData: image,
//                                        success: { response in print(response)},
//                                        fail: { response in print(response)})
    }
}
    
class HttpRequest {
    
    let manager = AFHTTPSessionManager()
    let baseURL = "http://localhost:8080/"
    
    init() {
        setSerializers()
    }
    
    //Set Session managers serializers.
    func setSerializers() {
        manager.requestSerializer = AFHTTPRequestSerializer()
        manager.responseSerializer = AFHTTPResponseSerializer()
    }
    
    //Add extension to baseURL
    func setURL(URLExtension: String) -> String {
        return baseURL + URLExtension
    }
    
    //Make standard api request with params.
    func post(params: [String: Any], URLExtension: String, success:@escaping ((String) -> Void), fail:@escaping (([String: Any]) -> Void)) {
        
        manager.post(self.setURL(URLExtension: URLExtension), parameters: params, progress: nil,
                     success: {(_ task: URLSessionDataTask, _ responseObject: Any) -> Void in
                        do {
                            let response = NSString(data: (responseObject as! NSData) as Data,
                                                    encoding: String.Encoding.utf8.rawValue)!
                            success(response as String)
                            
                        } catch {
                            print("Serialising new account json object went wrong.")
                        }
                        
        }, failure: { (operation, error) -> Void in
            let response = ["failed": error]
            fail(response)
        })
    }
    
    func handleError(_ error: NSError) -> UIAlertController {
        let alert = UIAlertController(title: "Please Try Again", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alert
    }
}
