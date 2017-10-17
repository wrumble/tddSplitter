//
//  OCRRequest.swift
//  Splitter
//
//  Created by Wayne Rumble on 28/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//
import UIKit

class OCRRequest {
    
    private let url = URL(string: "https://tesseractimageserver.herokuapp.com/extractText")!
    
    private var request: URLRequest!

    init(_ image: String) {
        var requestResponse = ""
        setupRequest(with: image)
        post(success: { response in requestResponse = response },
             fail: { response in requestResponse = response })
        print(requestResponse)
    }
    
    private func setupRequest(with image: String) {
        let params = ["image": image] as [String: Any]
        request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json",
                         forHTTPHeaderField: "Content-Type")
        request.addValue("application/json",
                         forHTTPHeaderField: "Accept")
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params,
                                                          options: .prettyPrinted)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func post(success: @escaping ( (String) -> Void ),
              fail: @escaping ( (String) -> Void )) {

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                let error = "Error: \(String(describing: error))"
                fail(error)
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                let error = "\(httpStatus.statusCode) error."
                fail(error)
            }
            
            let responseString = String(data: data, encoding: .utf8)
            success(responseString!)
        }
        task.resume()
    }
}
