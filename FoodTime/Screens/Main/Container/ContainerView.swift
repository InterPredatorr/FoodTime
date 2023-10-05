//
//  ContainerView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 10.09.23.
//

import SwiftUI

struct ContainerView: View {
    
    @EnvironmentObject var viewHandler: ViewSelectionManager
    @EnvironmentObject var basketManager: BasketManager
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    @State var presentingSideMenu = false
    @State private var isActivityEnabled = false

    
    var body: some View {
        ZStack(alignment: .center) {
            mainView
            sideMenuView
            if viewHandler.presentingPopupView {
                PopupView {
                    popupView
                }
            }
            if #available(iOS 16.1, *) {
                if isActivityEnabled {
                    ActivityView(isActivityEnabled: $isActivityEnabled)
                }
            }
            
        }
        .background(Color.mainColor.edgesIgnoringSafeArea(.all))
    }
}

extension ContainerView {
    var mainView: some View {
        VStack(spacing: 3) {
            MainScreenHeaderView(presentingSideMenu: $presentingSideMenu)
            MainView()
        }
    }
    
    var sideMenuView: some View {
        SideMenu(presentingSideMenu: presentingSideMenu) {
            SideMenuView(title: AccountManager.shared.myProfileInfo.fullname) { rowItem in
                viewHandler.handleSelectedTabAction(with: rowItem)
                presentingSideMenu.toggle()
            }
        } tapped: {
            isActivityEnabled.toggle()
            presentingSideMenu.toggle()
        }
    }
    
    var popupView: some View {
        Group {
            if viewHandler.presentingPopupView {
                PopupContainerView(config1: viewHandler.modalConfig1,
                                   config2: viewHandler.modalConfig2)
            }
        }
    }
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerView()
    }
}
