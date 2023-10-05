//
//  MyFavoritesView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 15.09.23.
//

import SwiftUI

struct MyFavoritesView: View {
    
    @EnvironmentObject var viewHandler: ViewSelectionManager
    @State private var contentRequestState: ButtonState = .pending
    let config = SettingsManager.shared.screens.myFavorites
    
    var body: some View {
        VStack {
            ContentHeaderView(title: config.title)
            if contentRequestState == .ready {
                contentView
            } else {
                pendingView
            }
        }
        .rootViewSetup()
    }
}

extension MyFavoritesView {
    
    var contentView: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                RestaurantsContentView(viewModel: .init(selectedRegionTitle: "Jay Capur")) {
                    withAnimation {
                        viewHandler.presentRestaurantDetailView = true
                        viewHandler.selectedView = .restaurants
                    }
                }
                .padding(.horizontal, Constants.screenPadding)
            }
        }
    }
    
    var pendingView: some View {
        ScrollView(showsIndicators: false) {
            ItemsListSkeletonView(isBigger: false)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation { contentRequestState = .ready }
                    }
                }
                .padding(.all, Constants.screenPadding)
        }
    }
}

struct MyFavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        MyFavoritesView()
    }
}
