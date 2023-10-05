//
//  RestaurantInfoView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 16.09.23.
//

import SwiftUI

struct RestaurantInfoView: View {
    
    let vendorInfo: [StringTuple]
    @State private var contentRequestState: ButtonState = .pending
    let config = SettingsManager.shared.screens.restaurants.restaurantDetail.tabs.info
    
    var body: some View {
        if contentRequestState == .ready {
            contentView
        } else {
            pendingView
        }
    }
}

extension RestaurantInfoView {
    var contentView: some View {
        ElevatedCard {
            VStack(alignment: .leading, spacing: 5) {
                TitleView(title: config.title.localized)
                ForEach(vendorInfo) { info in
                    HStack {
                        Text(info.value1)
                            .foregroundColor(.textPrimary)
                        Spacer()
                        Text(info.value2)
                            .foregroundColor(.textSecondary)
                    }
                }
            }
        }
        .padding(.all, Constants.screenPadding)
    }
    
    var pendingView: some View {
        KeyValuePairSkeletonView(count: 10)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation {
                        contentRequestState = .ready
                    }
                }
            }
            .padding(.all, Constants.screenPadding)
    }
}

struct RestaurantInfoView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantInfoView(vendorInfo: [.init("Name", "Arabic Palace"),
                                        .init("Cuisines", "Middle Eastern"),
                                        .init("Halal", "Yes"),
                                        .init("Status", "Closed"),
                                        .init("Working hours", Date().description),
                                        .init("Delivery hours", Date().description),
                                        .init("Google Address", ""),
                                        .init("Phone Number", "094610421"),
                                        .init("Payment Method", "Cash"),
                                        .init("Selected courier", "Vendor own delivery")])
    }
}
