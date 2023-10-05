//
//  MainScreenHeaderView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 23.09.23.
//

import SwiftUI

struct MainScreenHeaderView: View {
    
    @EnvironmentObject var basketManager: BasketManager
    @EnvironmentObject var viewHandler: ViewSelectionManager
    @Binding var presentingSideMenu: Bool
    let config = SettingsManager.shared.screens.main
    let constantSize = 30.0
    let imageSize = CGSize(width: 175, height: 50)
    
    var body: some View {
        HStack(spacing: 20) {
            Button {
                presentingSideMenu.toggle()
            } label: {
                Image(systemName: config.sideMenuImage)
                    .resizable()
                    .frame(width: constantSize, height: 20)
            }
            .padding(.vertical)
            Image(config.mainImage)
                .resizable()
                .frame(width: imageSize.width, height: imageSize.height)
                .onTapGesture {
                    withAnimation {
                        sendNotification()
//                        viewHandler.selectedView = .restaurants
//                        viewHandler.presentRestaurantDetailView = false
//                        viewHandler.showPopupWith(type: .twoButton(.init(title: "Oops", description: "description", leftButtonCompletion: {}, rightButtonCompletion: {})))
                    }
                }
            Spacer()
            Button {
                withAnimation { viewHandler.selectedView = .search }
            } label: {
                if viewHandler.selectedView != .search {
                    Image(systemName: config.searchImage)
                        .resizable()
                } else {
                    EmptyView()
                }
            }
            .frame(width: constantSize, height: constantSize)
            .padding(.vertical)
            Button {
                withAnimation { viewHandler.selectedView = .basket }
            } label: {
                ZStack(alignment: .topTrailing) {
                    Image(config.basketImage)
                        .resizable()
                    if !basketManager.items.isEmpty {
                        CircleView(padding: 2) {
                            Text(String(basketManager.items.count))
                                .font(.system(size: 18, weight: .semibold))
                                .minimumScaleFactor(0.5)
                        }
                        .offset(x: 5, y: -10)
                    }
                }
                .frame(width: constantSize, height: constantSize)
            }
            .padding(.vertical)
        }
        .padding(.horizontal, 16)
        .background(Color.mainColor)
        .foregroundColor(.white)
        .frame(height: constantSize * 2)
    }
    
    private func sendNotification() {
            let notificationContent = UNMutableNotificationContent()
            notificationContent.title = "Hello world!"
            notificationContent.subtitle = "Here's how you send a notification in SwiftUI"
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let req = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)
            UNUserNotificationCenter.current().add(req)
        }
}
