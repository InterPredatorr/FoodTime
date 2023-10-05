//
//  MyOrdersView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 15.09.23.
//

import SwiftUI



struct MyOrdersView: View {
    
    @EnvironmentObject var viewHandler: ViewSelectionManager
    @ObservedObject var viewModel: MyOrdersViewModel
    let config = SettingsManager.shared.screens.myOrders
    
    var body: some View {
        contentView
    }
}

extension MyOrdersView {
    var contentView: some View {
        VStack {
            ContentHeaderView(title: config.title.localized)
            if viewModel.requestStates.list == .ready {
                ordersView
            } else {
                pendingView
            }
        }
        .rootViewSetup()
    }
    
    var pendingView: some View {
        ScrollView(showsIndicators: false) {
            ItemsListSkeletonView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation { viewModel.requestStates.list = .ready }
                    }
                }
                .padding(.all, Constants.screenPadding)
        }
    }
    
    var ordersView: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ForEach($viewModel.orders) { order in
                    MyOrderCardView(order: order)
                        .onTapGesture {
                            withAnimation {
                                viewModel.selectedView = .detail(selectedOrder: order.wrappedValue)
                            }
                        }
                }
            }
            .padding(Constants.screenPadding)
        }
    }
}

struct MyOrderCardView: View {
    
    @Binding var order: MyOrderInfo
    @State private var requestState: ButtonState = .ready
    @EnvironmentObject var viewHandler: ViewSelectionManager
    @State private var presentingReviewScreen = false
    
    var body: some View {
        ElevatedCard(requestState: requestState) {
            VStack {
                MyOrderItemView(order: order)
                HStack(spacing: 10) {
                    StateableButtonView(title: LocalizedStrings.reorder, buttonColor: .mainGreen, height: 40, buttonState: $requestState) {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation { requestState = .ready }
                        }
                    }
                    .fixedSize()
                    if order.status == "SHIPPED" {
                        ButtonView(title: LocalizedStrings.call, buttonColor: .mainGreen, height: 40) {
                            //
                        }
                        .fixedSize()
                    }
                    if order.isMissingReview {
                        ButtonView(title: LocalizedStrings.review, buttonColor: .mainGreen, height: 40) {
                            presentingReviewScreen.toggle()
                        }
                        .fixedSize()
                        .sheet(isPresented: $presentingReviewScreen) {
                            MyOrderReviewView(myOrderInfo: order) {
                                order.isMissingReview = false
                                presentingReviewScreen.toggle()
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
        .onAppear {
            presentingReviewScreen = viewHandler.presentOrderReviewView
        }
    }
}

struct MyOrderItemView: View {
    
    let order: MyOrderInfo
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                Image(order.imageURL)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(Constants.cornerRadius)
                VStack(alignment: .leading, spacing: 2) {
                    Text(order.title)
                        .fontWeight(.bold)
                    Text(order.orderID)
                    Text(order.status)
                    Text(order.date)
                    Text(LocalizedStrings.cost + "RM " + order.cost.toString)
                }
                .font(.system(size: 14))
                Spacer()
            }
        }
        .padding(.all, 5)
    }
}

struct MyOrdersView_Previews: PreviewProvider {
    static var previews: some View {
        MyOrdersView(viewModel: .init())
    }
}
