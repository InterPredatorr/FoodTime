//
//  Extensions + String.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 23.09.23.
//

import Foundation
import SwiftUI

struct StringTuple: Hashable, Identifiable {
    var id = UUID()
    let value1: String
    let value2: String
    
    init(_ value1: String, _ value2: String) {
        self.value1 = value1
        self.value2 = value2
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(value1)
        hasher.combine(value2)
    }
    
    static func == (lhs: StringTuple, rhs: StringTuple) -> Bool {
        return lhs.value1 == rhs.value1 && lhs.value2 == rhs.value2
    }
}

extension String {
    var localized: String {
        let path = Bundle.main.path(forResource: language.rawValue, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    
    func replaceEmptyParentheses(selectedRegionTitle: String) -> String {
        return self.replacingOccurrences(of: "()", with: "(\(selectedRegionTitle))")
    }
}

extension Date
{
    func toString(dateFormat format: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
        
    }
}
