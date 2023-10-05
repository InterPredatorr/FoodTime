//
//  Extensions + (CGFloat, Double).swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 23.09.23.
//

import Foundation

extension CGFloat {
    func percent(_ percent: Self) -> Self {
        return self * percent / 100
    }
}

extension Double {
    
    var toString: String {
        String(self.exponent == 0 ? self.rounded() : self)
    }
    
    func removeZerosFromEnd() -> String {
        return String(format: "%.1f", self)
    }
}



