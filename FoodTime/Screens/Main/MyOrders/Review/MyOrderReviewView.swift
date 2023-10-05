//
//  MyOrderReviewView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 25.09.23.
//

import StoreKit
import SwiftUI

struct MyOrderReviewView: View {
    
    let myOrderInfo: MyOrderInfo
    let meals: [MealItemInfo] = [.init(imageURL: "", title: "Classic burger", description: "", cost: 3.5)]
    @State private var reviewtext = ""
    @State private var contentRequestState: ButtonState = .pending
    @State private var requestState: ButtonState = .ready
    let postButtonTapped: () -> Void
    
    var body: some View {
        VStack {
            ContentHeaderView(title: LocalizedStrings.myReviewTitle)
            if contentRequestState == .ready {
                contentView
            } else {
                pendingView
            }
        }
        .rootViewSetup()
    }
    
    
}

extension MyOrderReviewView {
    
    var contentView: some View {
        VStack {
            Spacer()
            ElevatedCard(requestState: requestState) {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 25) {
                        vendor
                        items
                        rating
                        review
                    }
                }
            }
            Spacer()
            button
        }
        .padding(.all, Constants.screenPadding)
    }
    
    var pendingView: some View {
        PopUpSkeletonView()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation { contentRequestState = .ready }
                }
            }
            .padding(.all, Constants.screenPadding)
    }
    
    var vendor: some View {
        Group {
            Text(LocalizedStrings.vendor)
                .foregroundColor(.mainColorDark)
                .font(.system(size: 20, weight: .bold))
            Text("Chef Red")
                .foregroundColor(.textPrimary)
        }
    }
    
    var items: some View {
        Group {
            Text(LocalizedStrings.items)
                .foregroundColor(.mainColorDark)
                .font(.system(size: 20, weight: .bold))
            ForEach(meals) { meal in
                HStack {
                    Spacer().frame(width: 20)
                    Image(systemName: Images.circleFilled)
                        .resizable()
                        .frame(width: 6, height: 6)
                    Text(meal.title)
                }
                .foregroundColor(.textPrimary)
            }
        }
    }
    
    var rating: some View {
        HStack {
            Spacer()
            StarsView(rating: 5, length: 40, allowedToChange: true)
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
    
    var review: some View {
        Group {
            Text(LocalizedStrings.review2)
                .foregroundColor(.textPrimary)
            TextView(text: $reviewtext, height: 100)
            Text(LocalizedStrings.canEarn)
        }
    }
    
    var button: some View {
        StateableButtonView(title: LocalizedStrings.post, buttonColor: .mainGreen, buttonState: $requestState) {
            postButtonTapped()
            SKStoreReviewController.requestReview()
        }
    }
}

#Preview {
    MyOrderReviewView(myOrderInfo: .init(imageURL: "", title: "", orderID: "", status: "", date: "", cost: 0.1)) { }
}
