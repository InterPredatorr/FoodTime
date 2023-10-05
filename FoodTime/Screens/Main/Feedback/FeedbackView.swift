//
//  FeedbackView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 18.09.23.
//

import SwiftUI

struct FeedbackView: View {
    
    @EnvironmentObject var viewHandler: ViewSelectionManager
    let config = SettingsManager.shared.screens.feedback
    @State private var title: String = ""
    @State private var feedback: String = ""
    @State var requestState: ButtonState = .ready
    var body: some View {
        VStack {
            contentView
        }
        .rootViewSetup()
    }
}

extension FeedbackView {
    var contentView: some View {
        Group {
            ContentHeaderView(title: config.title.localized)
            ElevatedCard(requestState: requestState) {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .center) {
                        Image(config.image)
                            .resizable()
                            .frame(width: 150, height: 150)
                            .padding()
                        Text(config.description.localized)
                            .font(.system(size: 20, weight: .regular))
                        Spacer()
                        TextFieldView(text: $title, config: config.fields.title, height: 40)
                        Text(config.fields.feedback.title.localized)
                            .font(.system(size: 16, weight: .semibold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        TextView(text: $feedback, height: 60)
                        Spacer()
                        StateableButtonView(title: config.sendButtonTitle, buttonColor: .mainColor, buttonState: $requestState) {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation { 
                                    viewHandler.selectedSideMenuTab = .restaurants
                                    requestState = .ready
                                }
                            }
                        }
                    }
                    Spacer()
                }
            }
            .padding(.all, Constants.screenPadding)
        }
    }
}

struct FeedbackView_Previews: PreviewProvider {
    static var previews: some View {
        FeedbackView()
    }
}

