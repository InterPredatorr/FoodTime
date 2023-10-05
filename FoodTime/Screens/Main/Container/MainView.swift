//
//  MainView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 12.09.23.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var viewHandler: ViewSelectionManager
    
    var body: some View {
        switch viewHandler.selectedView {
        case .login:
            LoginContainerView(viewModel: .init())
        case .myProfile:
            MyProfileContainerView(viewModel: .init() {
                viewHandler.logout()
                viewHandler.selectedSideMenuTab = .restaurants
            })
        case .restaurants:
            RestaurantsView(viewModel: .init(selectedRegionTitle: viewHandler.selectedRegion))
        case .myFavorites:
            MyFavoritesView()
        case .changeArea:
            ChangeAreaView(viewModel: .init())
        case .myOrders:
            MyOrdersContainerView(viewModel: .init())
        case .feedback:
            FeedbackView()
        case .search:
            SearchView(viewModel: .init())
        case .basket:
            BasketView()
        case .checkout:
            CheckoutContainerView(viewModel: .init())
        case .support:
            ChatView().environmentObject(ChatHelper())
        }
    }
}
