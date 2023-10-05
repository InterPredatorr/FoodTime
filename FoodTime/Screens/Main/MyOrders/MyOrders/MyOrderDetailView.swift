//
//  MyOrderDetailView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 23.09.23.
//

import SwiftUI

struct MyOrderDetailView: View {
    
    @EnvironmentObject private var accountManager: AccountManager
    @EnvironmentObject private var basketManager: BasketManager
    @ObservedObject var viewModel: MyOrdersViewModel
    let orderInfo: MyOrderInfo
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            contentView
        }
    }
}

extension MyOrderDetailView {
    
    var contentView: some View {
        VStack(alignment: .leading) {
            header
            orderMain
            orderType
            deliveryAddress
            orderHistory
            orderSummary
            paymentDetails
            deliveryTimeAndMethod
            ButtonView(title: LocalizedStrings.orderHistory, buttonColor: .mainGreen) {
                //
            }
            .fixedSize(v: false)
            Spacer()
        }
        .padding(Constants.screenPadding)
        .rootViewSetup()
    }
}

extension MyOrderDetailView {
    var header: some View {
        ContentHeaderView(title: addedOrderNumberToTitle)
    }
    
    var addedOrderNumberToTitle: String {
        var title = LocalizedStrings.orderDetails.uppercased()
        if let index = title.firstIndex(where: { $0 == " " }) {
            title.insert(contentsOf: String(" \(orderInfo.orderID) "), at: index)
            return title
        }
        return title
    }
    
    var orderMain: some View {
        ElevatedCard {
            MyOrderItemView(order: orderInfo)
        }
    }
    
    var orderType: some View {
        ElevatedCard {
            VStack(alignment: .leading) {
                cardTitle(with: LocalizedStrings.orderType)
                HStack(spacing: 10) {
                    ForEach(Array(viewModel.orderTypes.keys), id: \.self) { key in
                        OptionChooserView(title: key, isSelected: viewModel.orderTypes[key]!, disabled: true) { _ in }
                    }
                    Spacer()
                }
            }
        }
    }
    
    var deliveryAddress: some View {
        ElevatedCard {
            VStack(alignment: .leading) {
                cardTitle(with: LocalizedStrings.deliveryAddress)
                Text("Domain 1, 530, Persiaran Ceria, Cyber 12, 63000 Cyberjaya, Selangor, Malaysia")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(2)
            }
        }
    }
    
    var orderHistory: some View {
        ElevatedCard {
            VStack(alignment: .leading) {
                cardTitle(with: LocalizedStrings.orderHistory)
                PairView("Delivered", "10:14PM")
                PairView("Shipped", "10:15PM")
                PairView("Preparing", "10:16PM")
                PairView("Pending", "10:17PM")
            }
        }
    }
    
    var orderSummary: some View {
        ElevatedCard {
            VStack(alignment: .leading) {
                cardTitle(with: LocalizedStrings.orderSummary)
                summaryCard
            }
        }
    }
    
    var paymentDetails: some View {
        ElevatedCard {
            VStack {
                ContentHeaderView(title: LocalizedStrings.paymentDetailsTitle)
                PairView(LocalizedStrings.subtotal, "RM " + basketManager.subtotal)
                PairView(LocalizedStrings.sst, "RM " + "30")
                PairView(LocalizedStrings.delivery, "RM " + "30")
                PairView(LocalizedStrings.total, "RM " + "30")
                PairView(LocalizedStrings.allTaxes, "")
                
            }
        }
    }
    
    var deliveryTimeAndMethod: some View {
        ElevatedCard {
            VStack {
                PairView(LocalizedStrings.deliveryTime, "60min")
                PairView(LocalizedStrings.paymentMethod, "Online")
            }
        }
    }
    
}

extension MyOrderDetailView {
    
    var summaryCard: some View {
        HStack {
            Image("testChicken")
                .resizable()
                .frame(width: 100, height: 100)
                .cornerRadius(Constants.cornerRadius)
            VStack(alignment: .leading) {
                Text("Chicken Slices")
                Text("Quantity: 2")
                Text("RM 30")
                    .fontWeight(.bold)
                Spacer()
            }
            Spacer()
        }
    }
    
    func cardTitle(with text: String) -> some View {
        Text(text)
            .font(.system(size: 24, weight: .semibold))
            .foregroundColor(Color.mainColorDark)
    }
}

struct MyOrderDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MyOrderDetailView(viewModel: .init(),
                          orderInfo: .init(imageURL: "", title: "", orderID: "", status: "", date: "", cost: 0.1))
    }
}
