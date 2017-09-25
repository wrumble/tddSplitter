//
//  Regex.swift
//  Splitter
//
//  Created by Wayne Rumble on 25/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class Regex {
    let internalExpression: NSRegularExpression
    let pattern: String
    
    init(_ pattern: String) throws {
        self.pattern = pattern
        do {
            self.internalExpression = try NSRegularExpression(pattern: pattern,
                                                              options: .caseInsensitive)
        } catch let error {
            throw error
        }
    }
    
    func containsMatch(input: String) -> Bool {
        let matches = returnMatches(input: input)
        return matches.count > 0
    }
    
    func returnsMatchesAsStrings(input: String) -> [String] {
        let matches = returnMatches(input: input)
        
        return matches.map {
            let range = Range($0.range, in: input)!
            return String(input[range.lowerBound..<range.upperBound])
        }
    }
    
    private func returnMatches(input: String) -> [NSTextCheckingResult] {
        let range = NSRange(input.startIndex..., in: input)
        return internalExpression.matches(in: input,
                                          range: range)
    }
}
