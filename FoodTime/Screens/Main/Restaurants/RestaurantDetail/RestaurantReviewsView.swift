//
//  RestaurantReviewsView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 16.09.23.
//

import SwiftUI

struct RestaurantReviewsView: View {
    
    let reviewsInfo: ReviewsInfo
    @State private var contentRequestState: ButtonState = .pending
    let config = SettingsManager.shared.screens.restaurants.restaurantDetail.tabs.reviews
    
    var body: some View {
        VStack {
            if contentRequestState == .ready {
                contentView
            } else {
                pendingView
            }
        }
        .rootViewSetup()
    }
}

extension RestaurantReviewsView {
    var contentView: some View {
        VStack {
            summary
            reviews
        }
        .padding(.all, Constants.screenPadding)
    }
    
    var pendingView: some View {
        ScrollView(showsIndicators: false) {
            ItemsListSkeletonView()
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
    
    
}

extension RestaurantReviewsView {
    var summary: some View {
        ElevatedCard {
            VStack(alignment: .leading) {
                TitleView(title: config.summary.localized)
                RatingSummaryView(info: reviewsInfo)
            }
        }
    }
    
    var reviews: some View {
        ForEach(reviewsInfo.userReviews) { review in
            UserReviewView(itemInfo: review)
        }
    }
}

struct UserReviewView: View {
    
    let itemInfo: UserReviewInfo
    
    var body: some View {
        ElevatedCard {
            VStack(alignment: .leading) {
                HStack {
                    Text(itemInfo.name)
                        .foregroundColor(.textPrimary)
                        .font(.system(size: 24, weight: .bold))
                    RoundedView {
                        HStack {
                            Image(systemName: Images.starFilled)
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.mainYellow)
                            Text(itemInfo.rating.removeZerosFromEnd())
                                .foregroundColor(.white)
                        }
                    }
                    Spacer()
                }
                Text(itemInfo.date)
                Divider()
                Text(itemInfo.message)
                Divider()
                meals
            }
        }
    }
    
    var meals: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: Constants.screenPadding) {
                ForEach(itemInfo.meals) { meal in
                    MealCompactItemView(item: meal, ratio: 2.5, showingCost: false)
                }
            }
            .padding(.all, Constants.screenPadding)
        }
    }
}


struct RestaurantReviewsView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantReviewsView(reviewsInfo: .init(rating: 3.2, reviewsCount: 10, ratingCount1: 1,
                                                 ratingCount2: 3, ratingCount3: 2, ratingCount4: 3,
                                                 ratingCount5: 5,
                                                 userReviews: [.init(name: "name1",
                                                                     rating: 3.5,
                                                                     date: "\(Date().description)",
                                                                     message: "message1"),
                                                               .init(name: "name2",
                                                                     rating: 3.5,
                                                                     date: "\(Date().description)",
                                                                     message: "message2")]))
    }
}
