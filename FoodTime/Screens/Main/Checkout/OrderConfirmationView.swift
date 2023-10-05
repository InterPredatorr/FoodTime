//
//  OrderConfirmationView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 24.09.23.
//

import SwiftUI

struct OrderConfirmationView: View {
    
    @EnvironmentObject var viewHandler: ViewSelectionManager
    @ObservedObject var viewModel: CheckoutViewModel
    
    var body: some View {
        VStack {
            ContentHeaderView(title: LocalizedStrings.orderConfirmationTitle)
            contentView
            Spacer()
        }
        .padding(.horizontal, Constants.screenPadding)
        .rootViewSetup()
    }
}

extension OrderConfirmationView {
    
    var contentView: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 15) {
                topBadge
                orderDetails
                buttons
            }
        }
    }
    
    var topBadge: some View {
        ElevatedCard {
            VStack {
                Text(LocalizedStrings.awaitingConfirmation)
                Text("FoodTime Test")
                    .fontWeight(.bold)
                Image(Images.redClock)
                    .resizable()
                    .frame(width: 100, height: 100)
                Text(LocalizedStrings.thanksForOrder)
                    .multilineTextAlignment(.center)
                Text(LocalizedStrings.willGetNotified)
                    .multilineTextAlignment(.center)
            }
        }
    }
    
    var orderDetails: some View {
        Group {
            Text(LocalizedStrings.orderDetails)
                .font(.system(size: 28, weight: .bold))
            ElevatedCard {
                VStack {
                    PairView(LocalizedStrings.orderNumber, "FT-1111111")
                    PairView(LocalizedStrings.restaurant, "FoodTime Test")
                    PairView(LocalizedStrings.transactionTime, String(Date().description.dropLast(5)))
                    PairView(LocalizedStrings.estimatedTime, "60min")
                    PairView(LocalizedStrings.total, "RM 13.1")
                }
            }
            Divider()
        }
    }
    
    var buttons: some View {
        HStack {
            ButtonView(title: LocalizedStrings.viewOrder, buttonColor: .mainColorLight) {
                withAnimation { viewHandler.selectedView = .myOrders }
            }
            Spacer()
            ButtonView(title: LocalizedStrings.home, buttonColor: .mainGreen) {
                withAnimation { viewHandler.selectedView = .restaurants }
            }
        }
    }
}

struct OrderConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        OrderConfirmationView(viewModel: .init())
    }
}
