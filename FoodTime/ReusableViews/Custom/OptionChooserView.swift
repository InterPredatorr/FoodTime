//
//  OptionChooserView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 23.09.23.
//

import SwiftUI

struct OptionChooserView: View {
    
    let title: String
    let isSelected: Bool
    var disabled: Bool = false
    let tapped: (String) -> Void
    
    var body: some View {
        HStack {
            Button {
                tapped(title)
            } label: {
                Image(systemName: isSelected ? Images.circleFilledInsets : Images.circle)
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundColor(disabled ? .mainGrayDark : isSelected ? .blue : .textPrimary)
            }
            Text(title)
        }
        .padding(5)
        .fixedSize()
        .disabled(disabled)
        .onTapGesture {
            tapped(title)
        }
    }
}

struct OptionChooserView_Previews: PreviewProvider {
    static var previews: some View {
        OptionChooserView(title: "", isSelected: false, tapped: { _ in })
    }
}
import UIKit

