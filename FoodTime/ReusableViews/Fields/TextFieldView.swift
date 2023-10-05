//
//  TextFieldView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 10.09.23.
//

import SwiftUI

struct TextFieldView: View {
    
    @Binding var text: String
    let config: TextFieldConfig
    var isSecure = false
    var cornerRadius: CGFloat? = nil
    var background: Color? = nil
    var keyboardType: UIKit.UIKeyboardType = .default
    var padding: CGFloat = 16
    var height: CGFloat? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            if !config.title.isEmpty {
                Text(config.title.localized)
                    .foregroundColor(.textPrimary)
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
            }
            ZStack {
                HStack {
                    if text.isEmpty {
                        Text(config.placeholder.localized)
                            .foregroundColor(.textSecondary)
                            .font(.system(size: (height ?? 60) / 3, weight: .semibold))
                            .background(Color.clear)
                    }
                    Spacer()
                }
                .background(Color.clear)
                .padding(.leading, padding)
                textField()
                    .padding(.leading, padding)
                    .foregroundColor(.textPrimary)
                    .font(.system(size: (height ?? 60) / 3))
                    .frame(height: height ?? 60)
                    .textContentType(.emailAddress)
                    .textFieldStyle(.plain)
                    .keyboardType(keyboardType)
                RoundedRectangle(cornerRadius: cornerRadius ?? 10)
                    .stroke(lineWidth: 0.5)
                    .fill(Color.mainGrayDark.opacity(0.5))
                
            }
            .background(background)
            .cornerRadius(cornerRadius ?? 10)
        }
        .fixedSize(h: false)
    }
    
    @ViewBuilder
    func textField() -> some View {
        Group {
            if isSecure {
                SecureField("", text: $text)
            } else {
                TextField("", text: $text)
            }
        }
    }
}
