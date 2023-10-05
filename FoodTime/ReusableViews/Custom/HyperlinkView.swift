//
//  HyperlinkView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 24.09.23.
//

import SwiftUI
import UIKit

@available(iOS 16.0, *)
struct HyperlinkViewSwiftUI: View {
    
    var body: some View {
        Text(.init(getText()))
    }
    
    func getText() -> String {
        var text = LocalizedStrings.hyperlinkText
        text.replace(LocalizedStrings.privacyPolicy,
                     with: replaceWithLink(str1: LocalizedStrings.privacyPolicy,
                                           str2: Constants.privacyPolicyUrl))
        text.replace(LocalizedStrings.termsOfUse,
                     with: replaceWithLink(str1: LocalizedStrings.termsOfUse,
                                           str2: Constants.termsOfUseUrl))
        return text
    }
    
    func replaceWithLink(str1: String, str2: String) -> String {
        return "[\(str1)](\(str2))"
    }
}

struct HyperlinkView: UIViewRepresentable {

    let label = UILabel()
    var termsOfUseAttStr: NSMutableAttributedString = .init(string: "")
    var privacyPolicyAttStr: NSMutableAttributedString = .init(string: "")
    init() {
        self.termsOfUseAttStr = NSMutableAttributedString(string: LocalizedStrings.termsOfUse,
                                                                    attributes: attributes(link: Constants.termsOfUseUrl))
        self.privacyPolicyAttStr = NSMutableAttributedString(string: LocalizedStrings.privacyPolicy,
                                                                       attributes: attributes(link: Constants.privacyPolicyUrl))
        addAttributedString(privacyPolicyAttStr, replacingText: LocalizedStrings.privacyPolicy)
        addAttributedString(termsOfUseAttStr, replacingText: LocalizedStrings.termsOfUse)
    }
    
    @State var originalString: NSMutableAttributedString = .init(string: LocalizedStrings.hyperlinkText)
    
    func makeUIView(context: Context) -> some UIView {
        label.numberOfLines = 0
        label.attributedText = originalString
        label.sizeToFit()
        let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.labelTapped))
        label.addGestureRecognizer(tapGesture)
        label.isUserInteractionEnabled = true
        return label
    }

    func updateUIView(_ uiView: UIViewType, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator {
        var view: HyperlinkView
        
        init(_ view: HyperlinkView) {
            self.view = view
        }
        
        @objc func labelTapped(gesture: UITapGestureRecognizer) {
            if gesture.didTapAttributedString(LocalizedStrings.termsOfUse, in: view.label) {
                openUrl(Constants.termsOfUseUrl)
            } else if gesture.didTapAttributedString(LocalizedStrings.privacyPolicy, in: view.label) {
                openUrl(Constants.privacyPolicyUrl)
            }
        }
        
        func openUrl(_ url: String) {
            if let url = URL(string: url) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    func addAttributedString(_ str: NSAttributedString, replacingText: String) {
        if let range = LocalizedStrings.hyperlinkText.range(of: replacingText) {
            let nsRange = NSRange(range, in: LocalizedStrings.hyperlinkText)
            originalString.replaceCharacters(in: nsRange, with: str)
        }
    }
    
    func attributes(link: String) -> [NSAttributedString.Key : Any] {
        [NSAttributedString.Key.link: URL(string: link)!,
         NSAttributedString.Key.foregroundColor: UIColor.blue]
    }
    
    
}

extension UITapGestureRecognizer {
    
    func didTapAttributedString(_ string: String, in label: UILabel) -> Bool {
        guard let text = label.text else { return false }
        let range = (text as NSString).range(of: string)
        return self.didTapAttributedText(label: label, inRange: range)
    }
    
    private func didTapAttributedText(label: UILabel, inRange targetRange: NSRange) -> Bool {
        
        guard let attributedText = label.attributedText else {
            assertionFailure("attributedText must be set")
            return false
        }
        let textContainer = createTextContainer(for: label)
        
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainer)
        
        let textStorage = NSTextStorage(attributedString: attributedText)
        if let font = label.font {
            
            textStorage.addAttribute(NSAttributedString.Key.font, value: font, range: NSMakeRange(0, attributedText.length))
        }
        textStorage.addLayoutManager(layoutManager)
        
        let locationOfTouchInLabel = location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let alignmentOffset = aligmentOffset(for: label)
        
        let xOffset = ((label.bounds.size.width - textBoundingBox.size.width) * alignmentOffset) - textBoundingBox.origin.x
        let yOffset = ((label.bounds.size.height - textBoundingBox.size.height) * alignmentOffset) - textBoundingBox.origin.y
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - xOffset, y: locationOfTouchInLabel.y - yOffset)
        
        let characterTapped = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        let lineTapped = Int(ceil(locationOfTouchInLabel.y / label.font.lineHeight)) - 1
        let rightMostPointInLineTapped = CGPoint(x: label.bounds.size.width, y: label.font.lineHeight * CGFloat(lineTapped))
        let charsInLineTapped = layoutManager.characterIndex(for: rightMostPointInLineTapped, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return characterTapped < charsInLineTapped ? targetRange.contains(characterTapped) : false
    }
    
    private func createTextContainer(for label: UILabel) -> NSTextContainer {
        let textContainer = NSTextContainer(size: label.bounds.size)
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        return textContainer
    }
    
    private func aligmentOffset(for label: UILabel) -> CGFloat {
        
        switch label.textAlignment {
            
        case .left, .natural, .justified:
            return 0.0
        case .center:
            return 0.5
        case .right:
            return 1.0
            @unknown default:
            return 0.0
        }
    }
}
