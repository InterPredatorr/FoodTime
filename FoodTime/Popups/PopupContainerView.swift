//
//  PopupContainerView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 27.09.23.
//

import SwiftUI

enum ModalPopupType {
    case oneButton(ModalConfig1)
    case twoButton(ModalConfig2)
    
    struct ModalConfig1 {
        let title: String
        let description: String
        var buttonTitle: String = LocalizedStrings.ok
        let completion: () -> Void
    }
    
    struct ModalConfig2 {
        let title: String
        let description: String
        var leftButtonTitle: String = LocalizedStrings.ok
        var rightButtonTitle: String = LocalizedStrings.cancel
        let leftButtonCompletion: () -> Void
        let rightButtonCompletion: () -> Void
    }
}

struct PopupContainerView: View {
    
    @EnvironmentObject var viewHandler: ViewSelectionManager
    var config1: ModalPopupType.ModalConfig1? = nil
    var config2: ModalPopupType.ModalConfig2? = nil
    
    var body: some View {
        if viewHandler.presentingPopupView {
            PopupView {
                Group {
                    if let config1 {
                        ModalPopupView1(config: config1)
                    } else if let config2 {
                        ModalPopupView2(config: config2)
                    }
                }
            }
        }
    }
}

//#Preview {
//    PopupContainerView(config1: .init(title: "", description: "", completion: {}))
//}
