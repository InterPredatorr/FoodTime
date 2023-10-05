//
//  TextView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 17.09.23.
//

import SwiftUI
import UIKit

struct TextView: View {
    
    @Binding var text: String
    let height: CGFloat
    
    var body: some View {
        ZStack {
            TextViewRepresentable(text: $text)
                .cornerRadius(10)
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
                .fill(Color.mainGrayLight)
        }
        .frame(height: height)
        .fixedSize(h: false)
    }
}

struct TextViewRepresentable: UIViewRepresentable {
    
    @Binding var text: String
    var placeholder: String? = nil
    
    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.text = placeholder
        view.font = .systemFont(ofSize: 22)
        view.textColor = Color.textSecondary.uiColor()
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.delegate = context.coordinator
        view.contentInset = UIEdgeInsets(top: 5,
            left: 10, bottom: 5, right: 5)
        view.delegate = context.coordinator
        return view
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var control: TextViewRepresentable
     
        init(_ control: TextViewRepresentable) {
            self.control = control
        }
     
        func textViewDidChange(_ textView: UITextView) {
            control.text = textView.text
        }
        
        func textDidChange(_ notification: Notification) {
            guard let textView = notification.object as? UITextView else { return }
            control.text = textView.text
        }
        
        func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
            if textView.textColor == Color.textSecondary.uiColor() {
                textView.text = nil
                textView.textColor = Color.textPrimary.uiColor()
            }
            return true
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if (text as NSString).rangeOfCharacter(from: CharacterSet.newlines).location == NSNotFound {
                return true
            }
            textView.resignFirstResponder()
            return false
        }
    }
}

