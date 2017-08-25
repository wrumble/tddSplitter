//
//  EmailTestHelper.swift
//  Splitter
//
//  Created by Wayne Rumble on 23/08/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import XCTest

class EmailTestHelper {
    
    func createEmail(with functionName: String) -> String {
        let brackets = CharacterSet(charactersIn: "()")
        let cleanedFunctionName = functionName.components(separatedBy: brackets).joined()
        
        return "\(cleanedFunctionName)@email.com"
    }
}
