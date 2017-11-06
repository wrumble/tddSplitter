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
    
    private let manager = AFHTTPSessionManager()
    private let url = "http://45.55.68.131:8080/extractText"
    
    init() {
        setSerializers()
    }
    
    func uploadReceiptImage(image: String,
                            complete: @escaping ((String?) -> Void)) {
        let params = ["image": image] as [String: Any]
        post(params: params,
             success: { response in complete(response) },
             fail: { response in complete(response)}
        )
    }
    
   private func setSerializers() {
        manager.requestSerializer = AFHTTPRequestSerializer()
        manager.responseSerializer = AFHTTPResponseSerializer()
    }
    
    private func post(params: [String: Any],
                      success: @escaping ((String) -> Void),
                      fail: @escaping ((String?) -> Void)) {
        manager.post(url,
                     parameters: params,
                     progress: nil,
                     success: {(_ task: URLSessionDataTask, _ responseObject: Any) -> Void in
                        let response = NSString(data: (responseObject as! NSData) as Data,
                                                encoding: String.Encoding.utf8.rawValue)!
                        success(response as String)
                        
        }, failure: { ( _, error) -> Void in
            print("Image post request failed: \(error)")
            fail(nil)
        })
    }
}
