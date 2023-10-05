//
//  OrderTypeChooserView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 26.09.23.
//

import SwiftUI

struct OrderTypeChooserView: View {
    
    var title: String
    var options: [String]
    var disabled: Bool = false
    @State private var current = ""
    let optionChanged: (String) -> Void
    
    var body: some View {
        ElevatedCard {
            VStack(alignment: .leading) {
                TitleView(title: title)
                HStack(spacing: 10) {
                    ForEach(options, id: \.self) { option in
                        OptionChooserView(title: option, isSelected: option == current, disabled: disabled) { option in
                            current = option
                            optionChanged(option)
                        }
                    }
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    OrderTypeChooserView(title: "", options: [""], optionChanged: { _ in })
}
