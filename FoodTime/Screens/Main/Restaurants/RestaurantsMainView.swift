//
//  RestaurantsMainView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 17.09.23.
//

import SwiftUI

struct RestaurantsMainView: View {
    
    @EnvironmentObject var viewHandler: ViewSelectionManager
    @ObservedObject var viewModel: RestaurantsViewModel
    @State private var contentRequestState: ButtonState = .pending
    let adsRatio = 4.1
    let config = SettingsManager.shared.screens.restaurants
    var body: some View {
        VStack {
            ContentHeaderView(title: title, height: 50, fontSize: 15)
                .onTapGesture {
                    withAnimation { viewHandler.selectedView = .changeArea }
                }
            if contentRequestState == .ready {
                contentView
            } else {
                pendingView
            }
        }
        .rootViewSetup()
    }
    
    var title: String {
        config.title.localized.replaceEmptyParentheses(selectedRegionTitle: viewModel.selectedRegionTitle)
    }
}

extension RestaurantsMainView {
    var contentView: some View {
        VStack(spacing: 15) {
            topAds
            subtitle
            tabs
            SearchFieldView(placeholder: config.searchPlaceholder.localized + viewModel.selectedRegionTitle,
                            text: $viewModel.searchText)
            RestaurantsContentView(viewModel: viewModel) {
                withAnimation { viewHandler.presentRestaurantDetailView.toggle() }
            }
            Spacer()
        }
        .edgesIgnoringSafeArea(.bottom)
        .padding(.horizontal, 8)
        .background(Color.background)
    }
    
    var pendingView: some View {
        MainSkeletonView()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation { contentRequestState = .ready }
                }
            }
            .padding(.all, Constants.screenPadding)
    }
}

extension RestaurantsMainView {
    var topAds: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(viewModel.images, id: \.self) { image in
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .cornerRadius(Constants.cornerRadius)
                        .onTapGesture {
                            withAnimation { viewHandler.presentRestaurantDetailView = true }
                        }
                }
            }
            .frame(height: Constants.screenWidth / adsRatio)
        }
    }
    
    var tabs: some View {
        TabsView(items: Array(viewModel.restaurants.keys.sorted(by: <))) { selectedTab in
            viewModel.updateTabContent(with: selectedTab)
        }
    }
    
    var subtitle: some View {
        TitleView(title: config.subtitle.localized)
            .fixedSize(h: false)
    }
}

struct RestaurantsContentView: View {
    
    @ObservedObject var viewModel: RestaurantsViewModel
    let restaurantItemTapped: () -> Void
    
    var body: some View {
        VStack {
            ForEach($viewModel.selectedTabRestaurants) { content in
                RestaurantItemView(itemInfo: content)
                    .onTapGesture {
                        restaurantItemTapped()
                    }
            }
            Spacer()
        }
    }
}
