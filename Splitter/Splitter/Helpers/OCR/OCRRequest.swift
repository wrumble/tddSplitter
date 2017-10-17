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
    let manager = AFHTTPSessionManager()
    let url = "https://tesseractimageserver.herokuapp.com/extractText"
    
    init() {
        setSerializers()
    }
    
    func uploadReceiptImage(image: String) {
        let params = ["image": image] as [String: Any]
        post(params: params,
             success: { response in print(response)},
             fail: { response in print(response)})

    }
    
    func setSerializers() {
        manager.requestSerializer = AFHTTPRequestSerializer()
        manager.responseSerializer = AFHTTPResponseSerializer()
    }
    
    func post(params: [String: Any],
              success:@escaping ((String) -> Void),
              fail:@escaping (([String: Any]) -> Void)) {
        
        manager.post(url, parameters: params, progress: nil,
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
        let alert = UIAlertController(title: "Please Try Again",
                                      message: error.localizedDescription,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .cancel,
                                      handler: nil))
        return alert
    }
}
