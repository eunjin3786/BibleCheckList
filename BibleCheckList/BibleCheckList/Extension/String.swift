//
//  String.swift
//  BibleCheckList
//
//  Created by eunjin Jo on 19/11/2018.
//  Copyright © 2018 eunjin. All rights reserved.
//
import Foundation

extension String{
    
    func getArrayAfterRegex(regex: String) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: self,
                                        range: NSRange(self.startIndex..., in: self))
            return results.map {
                String(self[Range($0.range, in: self)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
