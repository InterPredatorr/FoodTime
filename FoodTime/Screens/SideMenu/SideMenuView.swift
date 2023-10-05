//
//  SideMenuView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 10.09.23.
//

import SwiftUI

enum SideMenuRowType: String, CaseIterable {
    case login
    case myProfile
    case restaurants
    case myFavorites
    case changeArea
    case myOrders
    case feedback
    case support
    case logout

    var titleKey: String {
        switch self {
        case .login:
            return "login_or_register"
        case .myProfile:
            return "my_profile"
        case .restaurants:
            return "restaurants"
        case .myFavorites:
            return "my_favorites"
        case .changeArea:
            return "change_area"
        case .myOrders:
            return "my_orders"
        case .feedback:
            return "feedback"
        case .support:
            return "support"
        case .logout:
            return "logout"
        }
    }

    var iconName: String {
        return self.rawValue
    }
}

struct SideMenuRowItem: Identifiable, Hashable {
    var id = UUID()
    var type: SideMenuRowType
    var isEnabled: Bool
}

struct SideMenuView: View {
    
    let title: String
    @EnvironmentObject var viewHandler: ViewSelectionManager
    let tapped: (SideMenuRowType) -> Void
    let imgLenght = 26.0
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 50) {
                ContentHeaderView(title: title, foregroundColor: .white,
                                  midRectangleColor: .white, rectangleColor: .mainColorDark)
                    .foregroundColor(.mainWhite)
                    .padding(.horizontal)
                ScrollView(showsIndicators: false) {
                    ForEach(viewHandler.sideMenuItems.filter { $0.isEnabled }, id: \.self) { row in
                        RowView(imageName: row.type.iconName, title: row.type.titleKey.localized) {
                            withAnimation { tapped(row.type) }
                        }
                    }
                    Spacer()
                }
            }
            .padding(.top, 60)
            .frame(width: Constants.screenWidth.percent(70))
            .background(
                Rectangle()
                    .fill(Color.mainColorLight)
                    .frame(width: Constants.screenWidth.percent(70))
            )
            Spacer()
        }
    }
    
    func RowView(imageName: String, title: String, action: @escaping (() -> Void)) -> some View {
        Button {
            action()
        } label: {
                HStack(spacing: 20) {
                    Image(imageName)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.white.opacity(0.5))
                        .frame(width: imgLenght, height: imgLenght)
                    TitleView(title: title, color: .white)
                    Spacer()
                }
                .padding(.leading, 20)
        }
        .frame(height: 50)
    }
}

