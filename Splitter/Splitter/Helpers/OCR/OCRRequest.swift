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
    private let url = "http://localhost:8080/extractText"
    
    init() {
        setSerializers()
    }
    
    func uploadReceiptImage(image: String,
                            complete: @escaping ((String?) -> Void)) {
        let params = ["image": image] as [String: Any]
        post(params: params,
             success: { response in complete(response) },
             fail: { response in complete(response)})
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
            print("failed \(error)")
            fail(nil)
        })
    }
    
//    private let url = URL(string: "https://tesseractimageserver.herokuapp.com/extractText")!
//    private var request: URLRequest!
//
//    init(_ image: String) {
//        setupRequest(with: image)
//        post(success: { response in print(response) },
//             fail: { response in print(response) })
//    }
//
//    private func setupRequest(with image: String) {
//        let params = ["image": image] as [String: Any]
//        request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/json",
//                         forHTTPHeaderField: "Content-Type")
//        request.addValue("application/json",
//                         forHTTPHeaderField: "Accept")
//        do {
//            request.httpBody = try JSONSerialization.data(withJSONObject: params,
//                                                          options: .prettyPrinted)
//        } catch let error {
//            print(error.localizedDescription)
//        }
//    }
//
//    private func post(success: @escaping ( (String) -> Void ),
//                      fail: @escaping ( (String) -> Void )) {
//
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data,
//                      error == nil else {
//                let error = "Error: \(String(describing: error))"
//                fail(error)
//                return
//            }
//
//            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
//                let error = "\(httpStatus.statusCode) error."
//                fail(error)
//            }
//
//            let responseString = String(data: data, encoding: .utf8)
//            success(responseString!)
//        }
//        task.resume()
//    }
}
