//
//  OCRRequest.swift
//  Splitter
//
//  Created by Wayne Rumble on 28/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import Foundation

class OCRRequest {
    
    let session = URLSession.shared
    let googleAPIKey = "AIzaSyAPpD4rR9d2rQ8DLQHXFfL3_zbNOBgY9ag"
    var googleURL: URL {
        return URL(string: "https://vision.googleapis.com/v1/images:annotate?key=\(googleAPIKey)")!
    }
    
    func createRequest(with base64Image: String) {
        // Create our request URL
        
        var request = URLRequest(url: googleURL)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue(Bundle.main.bundleIdentifier ?? "", forHTTPHeaderField: "X-Ios-Bundle-Identifier")
        
        // Build our API request
        let jsonRequest = ["requests": ["image": ["content": base64Image], "features": [["type": "TEXT_DETECTION"]]]]
        let  jsonData = try? JSONSerialization.data(withJSONObject: jsonRequest)
        
        request.httpBody = jsonData
        
        // Run the request on a background thread
        DispatchQueue.global().async {
            let task: URLSessionDataTask = self.session.dataTask(with: request) { (data, _, error) in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
                self.printResults(data)
            }
            
            task.resume()
        }
    }
    
    private func printResults(_ data: Data) {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            let json = jsonObject!["responses"] as? [[String: Any]]
            let responses = json![0]
            let fullTextAnnotation = responses["fullTextAnnotation"] as! [String: Any]
            let receiptText = fullTextAnnotation["text"] as! String
            print(receiptText)
            receiptText.enumerateLines { receiptLine, _ in
                print(receiptLine)
                let converter = OCRResultConverter()
                let items = converter.convertToItems(receiptLine,
                                                     billID: "9FA261C5-DDF9-40AF-94A5-D81356CE9A21")
                print(items)
            }
        } catch {
            print("Error deserializing JSON: \(error)")
        }
    }
}
