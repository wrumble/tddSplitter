//
//  Regex.swift
//  Splitter
//
//  Created by Wayne Rumble on 25/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class Regex {
    
    private let internalExpression: NSRegularExpression
    private let pattern: String
    
    init(_ pattern: String) throws {
        self.pattern = pattern
        do {
            self.internalExpression = try NSRegularExpression(pattern: pattern,
                                                              options: .caseInsensitive)
        } catch let error {
            throw error
        }
    }
    
    func returnRegexResultsFrom(_ text: String) -> [String]? {
        if containsMatch(input: text) {
            return returnMatchesAsStrings(input: text)
        } else {
            print("No match found with regex pattern")
            return nil
        }
    }
    
    private func containsMatch(input: String) -> Bool {
        let matches = returnMatches(input: input)
        return matches.count > 0
    }
    
    private func returnMatchesAsStrings(input: String) -> [String] {
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
