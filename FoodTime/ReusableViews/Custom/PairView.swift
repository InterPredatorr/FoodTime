//
//  PairView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 27.09.23.
//

import SwiftUI

struct PairView: View {
    
    let key: String
    let value: String
    
    init(_ key: String,_ value: String) {
        self.key = key
        self.value = value
    }
    
    var body: some View {
        HStack {
            Text(key)
            Spacer()
            Text(value)
                .foregroundColor(.mainGrayDark)
        }
    }
}

#Preview {
    PairView("~", "~")
}
