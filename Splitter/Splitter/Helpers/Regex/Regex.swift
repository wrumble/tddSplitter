//
//  Regex.swift
//  Splitter
//
//  Created by Wayne Rumble on 25/09/2017.
//  Copyright © 2017 Wayne Rumble. All rights reserved.
//

import UIKit

class Regex {
    
    func listMatches(of pattern: String,
                     in string: String) -> [String] {
        let regex = regexWith(pattern)!
        let range = rangeOf(string)
        let matches = regex.matches(in: string, range: range)
        
        return matches.map {
            let range = $0.range
            return (string as NSString).substring(with: range)
        }
    }
    
    func contains(pattern: String,
                  in string: String) -> Bool {
        let regex = regexWith(pattern)!
        let range = rangeOf(string)
        return regex.firstMatch(in: string, range: range) != nil
    }
    
    func replaceMatch(of pattern: String,
                      in string: String,
                      with replacementString: String) -> String? {
        let regex = regexWith(pattern)!
        let range = rangeOf(string)
        
        return regex.stringByReplacingMatches(in: string,
                                              range: range,
                                              withTemplate: replacementString)
    }
    
    private func regexWith(_ pattern: String) -> NSRegularExpression? {
        do {
            return try NSRegularExpression(pattern: pattern,
                                           options: .caseInsensitive)
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    private func rangeOf(_ string: String) -> NSRange {
        return NSRange(string.startIndex..., in: string)
    }
}
