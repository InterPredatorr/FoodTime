//
//  RestaurantDetailView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 16.09.23.
//

import SwiftUI

struct RestaurantDetailView: View {
    
    enum RestaurantDetailTabs: String, CaseIterable {
        case menu
        case reviews
        case info
    }
    
    @EnvironmentObject var viewHandler: ViewSelectionManager
    @State var itemInfo: RestaurantDetailInfo
    @State var selectedTab: RestaurantDetailTabs = .menu
    @State private var contentRequestState: ButtonState = .pending
    let config = SettingsManager.shared.screens.restaurants.restaurantDetail
    private let starSize = 20.0
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            if contentRequestState == .ready {
                contentView
            } else {
                pendingView
            }
        }
        .rootViewSetup()
        .onDisappear {
            viewHandler.presentRestaurantDetailView = false
        }
    }
}

extension RestaurantDetailView {
    var contentView: some View {
        VStack {
            VStack {
                topImage
                restaurantMainInfo
                tabsView
            }
            .padding([.horizontal, .top], Constants.screenPadding)
            mainContent
        }
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

extension RestaurantDetailView {
        
    var topImage: some View {
        Group {
            ZStack(alignment: .topTrailing) {
                Image(itemInfo.backgroundImage)
                    .resizable()
                    .frame(height: Constants.screenHeight / 4)
                    .frame(maxWidth: .infinity)
                    .cornerRadius(Constants.cornerRadius)
                ElevatedCard(padding: 0) {
                    Button {
                        itemInfo.isFavorite.toggle()
                    } label: {
                        Image(systemName: itemInfo.isFavorite ? Images.starFilled : Images.star)
                            .resizable()
                            .frame(width: starSize, height: starSize)
                            .foregroundColor(.mainYellow)
                            .padding(.all, 10)
                    }
                }
                .padding(.all, 8)
            }
        }
    }
    
    var restaurantMainInfo: some View {
        ElevatedCard {
            VStack {
                HStack {
                    RestaurantImageView(image: itemInfo.mainImage)
                        .frame(width: 100, height: 100)
                    VStack(alignment: .leading, spacing: 10) {
                        StarsView(rating: itemInfo.rating)
                        Text(itemInfo.title)
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.textPrimary)
                        Text(itemInfo.restaurantType)
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.textSecondary)
                        Spacer()
                    }
                    Spacer()
                }
                .fixedSize(h: false)
                VStack(alignment: .leading) {
                    HStack {
                        label(image: Images.clock, text: itemInfo.openTime)
                        RoundedView(backgroundColor: .mainColorDark) {
                            Text(LocalizedStrings.closed)
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                        }
                        Spacer()
                    }
                    label(image: Images.delivery,
                          text: LocalizedStrings.deliveryFee + itemInfo.deliveryFee + " · " + itemInfo.deliveryDuration)
                    label(image: Images.location,
                          text: itemInfo.location)
                }
            }
        }
    }
    
    var tabsView: some View {
        ElevatedCard {
            HStack {
                ForEach(RestaurantDetailTabs.allCases, id: \.self) { tab in
                    NavigationBarItemView(isSelected: tab.rawValue == selectedTab.rawValue) {
                        Text(tab.rawValue.localized)
                            .fixedSize()
                            .frame(maxWidth: .infinity)
                    } tapped: {
                        withAnimation { selectedTab = tab }
                    }
                    if tab != .info { Divider() }
                }
            }
        }
    }
    
    var mainContent: some View {
        VStack {
            switch selectedTab {
            case .menu:
                RestaurantMenuView()
            case .reviews:
                RestaurantReviewsView(reviewsInfo: itemInfo.reviews)
            case .info:
                RestaurantInfoView(vendorInfo: itemInfo.info)
            }
        }
        .padding(.vertical, 10)
    }
    
    
    
    func label(image: String, text: String) -> some View {
        HStack {
            Image(image)
                .resizable()
                .frame(width: 20, height: 20)
            Text(text.localized)
        }
        .foregroundColor(.textPrimary)
    }
}

struct RestaurantDetailView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDetailView(itemInfo: .init(backgroundImage: "restaurantDetail",
                                             mainImage: "appIcon", title: "Arabic Palace",
                                             rating: 3.0, restaurantType: "Middle Eastern",
                                             openTime: "11:00AM - 10:00PM",
                                             deliveryFee: "Free",
                                             deliveryDuration: "60mins", location: "Sungai Chua", menu: [:],
                                             reviews: .init(rating: 3.2, reviewsCount: 3, ratingCount1: 3,
                                                            ratingCount2: 3, ratingCount3: 3, ratingCount4: 3,
                                                            ratingCount5: 3, userReviews: []),
                                             info: [], isFavorite: true))
    }
}
