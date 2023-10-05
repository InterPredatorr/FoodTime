//
//  ViewSelectionManager.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 19.09.23.
//

import SwiftUI

enum SelectedView: String, CaseIterable {
    case login
    case myProfile
    case restaurants
    case myFavorites
    case changeArea
    case myOrders
    case feedback
    case search
    case basket
    case checkout
    case support
}

class ViewSelectionManager: ObservableObject {
    
    @Published var sideMenuItems: [SideMenuRowItem] = [.init(type: .login, isEnabled: true),
                                                       .init(type: .myProfile, isEnabled: false),
                                                       .init(type: .restaurants, isEnabled: true),
                                                       .init(type: .myFavorites, isEnabled: false),
                                                       .init(type: .changeArea, isEnabled: true),
                                                       .init(type: .myOrders, isEnabled: false),
                                                       .init(type: .feedback, isEnabled: true),
                                                       .init(type: .support, isEnabled: true),
                                                       .init(type: .logout, isEnabled: false)]
    
    
    
    @Published var selectedSideMenuTab: SideMenuRowType = .restaurants
    @Published var selectedView: SelectedView = .restaurants
    @Published var currentOrder: MyOrderInfo = .init(imageURL: "", title: "", orderID: "", status: "", date: "", cost: 0.0)
    @Published var selectedRegion = "Cyber Jaya"
    @Published var recentlySearchedAreas = ["Cyber Jaya"]
    @Published var presentRestaurantDetailView = false
    @Published var presentOrderReviewView = false
    @Published var presentingPopupView = false
    @Published var searchTab: SearchType = .restaurants
    @Published var searchText: String = ""
    @Published private(set) var modalConfig1: ModalPopupType.ModalConfig1? = nil
    @Published private(set) var modalConfig2: ModalPopupType.ModalConfig2? = nil
    private let logedOutTypes: [SideMenuRowType] = [.login, .restaurants, .changeArea, .feedback, .support]
    
    var presentingSearch: Bool {
        selectedView == .search
    }
    
    var lastSearchedArea: String {
        recentlySearchedAreas.isEmpty ? "" : recentlySearchedAreas[0]
    }
    
    func showPopupWith(type: ModalPopupType) {
        switch type {
        case let .oneButton(config):
            modalConfig1 = config
        case let .twoButton(config):
            modalConfig2 = config
        }
        presentingPopupView = true
    }
    
    func addNewRegion(_ region: String) {
        selectedRegion = region
        selectedView = .restaurants
        if recentlySearchedAreas.first != region {
            recentlySearchedAreas.insert(region, at: 0)
            if recentlySearchedAreas.count == 4 {
                recentlySearchedAreas.remove(at: 3)
            }
        }
    }
    
    func handleSelectedTabAction(with tab: SideMenuRowType) {
        switch tab {
        case .logout:
            logout()
        default:
            selectedView = .init(rawValue: tab.rawValue) ?? .restaurants
        }
        presentRestaurantDetailView = false
        presentOrderReviewView = false
    }
    
    func login() {
        sideMenuItems = sideMenuItems.map { .init(type: $0.type, isEnabled: $0.type != .login) }
        selectedView = .restaurants
        NotificationsManager.loginToOneSignal()
    }
    
    func logout() {
        sideMenuItems = sideMenuItems.map { item in
            SideMenuRowItem(type: item.type,
                            isEnabled: logedOutTypes.contains(where: { item.type == $0 }))
        }
        selectedView = .restaurants
    }
}
