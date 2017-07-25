//
//  DateHelper.swift
//  Splitter
//
//  Created by Wayne Rumble on 24/07/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import Foundation

extension Date {
    
    func currentDateTimeAsString() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm dd/MM/yyyy"
        
        return formatter.string(from: date)
    }
}
