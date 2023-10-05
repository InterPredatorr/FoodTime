//
//  CheckoutView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 22.09.23.
//

import SwiftUI

struct MyInfo: Codable {
    let phone: String
    let deliveryTime: String
    let vendorName: String
}

struct CheckoutItemInfo {
    var orderType: String
    var myInfo: MyInfo
    var deliveryAddress: AddressInfo
    var deliveryNote: String
    var voucher: String
    var paymentMethod: String
    var subtotal: Double
}

struct CheckoutView: View {
    
    @EnvironmentObject var viewHandler: ViewSelectionManager
    @EnvironmentObject var basketManager: BasketManager
    @ObservedObject var viewModel: CheckoutViewModel
    @State private var presentSheet = false
    
    var body: some View {
        VStack {
            header
            ScrollView(showsIndicators: false) {
                if viewModel.requestStates.content == .ready {
                    contentView
                } else {
                    pendingView
                }
            }
        }
        .rootViewSetup()
    }
}

extension CheckoutView {
    var contentView: some View {
        VStack(spacing: 15) {
            orderType
            myInfo
            deliveryAddress
            deliveryNotes
            voucher
            paymentMethods
            paymentDetails
            placeOrderButton
            Spacer()
        }
        .padding(.all, 10)
        .onAppear {
            
        }
    }
    
    var pendingView: some View {
        MainSkeletonView()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation { viewModel.requestStates.content = .ready }
                }
            }
            .padding(.all, Constants.screenPadding)
            
    }
}



extension CheckoutView {
    
    var header: some View {
        ContentHeaderView(title: LocalizedStrings.checkoutTitle)
    }
    
    var orderType: some View {
        OrderTypeChooserView(title: LocalizedStrings.orderType, options: Array(viewModel.orderTypes.keys)) { option in
            viewModel.updateOrderType(with: option)
        }
    }
    
    var myInfo: some View {
        ElevatedCard {
            VStack(alignment: .leading, spacing: 10) {
                TitleView(title: LocalizedStrings.myInfo)
                PairView(LocalizedStrings.myPhone, viewModel.checkoutItemInfo.myInfo.phone)
                PairView(LocalizedStrings.deliveryTime, viewModel.checkoutItemInfo.myInfo.deliveryTime)
                PairView(LocalizedStrings.vendorName, viewModel.checkoutItemInfo.myInfo.vendorName)
            }
        }
    }
    
    var deliveryAddress: some View {
        ElevatedCard(padding: 5) {
            VStack(alignment: .leading, spacing: 10) {
                TitleView(title: LocalizedStrings.deliveryAddress)
                addresses
                addAddressButton
            }
        }
    }
    
    var deliveryNotes: some View {
        ElevatedCard {
            VStack(alignment: .leading, spacing: 10) {
                TitleView(title: LocalizedStrings.deliveryNote)
                TextView(text: $viewModel.checkoutItemInfo.deliveryNote, height: 100)
            }
        }
    }
    
    var voucher: some View {
        ElevatedCard {
            VStack(alignment: .leading, spacing: 10) {
                TitleView(title: LocalizedStrings.voucher)
                HStack(spacing: 10) {
                    TextFieldView(text: $viewModel.checkoutItemInfo.voucher,
                                  config: .init(title: "",
                                                placeholder: LocalizedStrings.voucherCode),
                                  height: 40)
                    StateableButtonView(title: LocalizedStrings.redeem,
                                        buttonColor: .mainGreen,
                                        buttonState: $viewModel.requestStates.redeem) {
                        //
                    }
                    .fixedSize()
                }
                Text(LocalizedStrings.invalidPromo)
                    .foregroundColor(.mainColor)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
    }
    
    var paymentMethods: some View {
        ElevatedCard {
            VStack(alignment: .leading, spacing: 10) {
                TitleView(title: LocalizedStrings.paymentMethod)
                HStack(spacing: 10) {
                    ForEach(Array(viewModel.paymentMethods.keys), id: \.self) { key in
                        OptionChooserView(title: key, isSelected: viewModel.paymentMethods[key]!) { method in
                            viewModel.updatePaymentMethod(with: method)
                        }
                    }
                    Spacer()
                }
            }
        }
    }
    
    var paymentDetails: some View {
        ElevatedCard {
            VStack(alignment: .leading, spacing: 10) {
                ContentHeaderView(title: LocalizedStrings.paymentDetailsTitle)
                PairView(LocalizedStrings.subtotal, basketManager.subtotal)
                PairView(LocalizedStrings.delivery, "-")
                PairView(LocalizedStrings.total, "-")
                PairView(LocalizedStrings.allTaxes, "")
            }
        }
    }
    
    var placeOrderButton: some View {
        Group {
            Divider()
            StateableButtonView(title: LocalizedStrings.placeOrder, buttonColor: .mainGreen, buttonState: $viewModel.requestStates.placeOrder) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation { 
                        viewModel.currentView = .confirmation
                        viewModel.requestStates.placeOrder = .ready
                    }
                }
            }
        }
    }
    
}

extension CheckoutView {
    var addAddressButton: some View {
        ButtonView(title: LocalizedStrings.add, buttonColor: .mainGreen) {
            presentSheet.toggle()
        }
        .sheet(isPresented: $presentSheet) {
            AddNewAddressView { newAddress in
                AccountManager.shared.addNewAddress(newAddress)
                presentSheet.toggle()
            }
        }
    }
    
    var addresses: some View {
        ForEach(AccountManager.shared.myProfileInfo.addressBook) { address in
            ElevatedCard(padding: 10) {
                HStack {
                    VStack(alignment: .leading, spacing: 10)  {
                        Text(address.addressName)
                            .foregroundColor(.mainGreen)
                            .font(.system(size: 20, weight: .semibold))
                        Text(address.address)
                            .lineLimit(2)
                            .font(.system(size: 14))
                    }
                    Spacer()
                    Image(systemName: address.isSelected ? Images.circleFilledInsets : Images.circle)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(address.isSelected ? .blue : .textPrimary)
                }
            }
            .onTapGesture {
                withAnimation {
                    AccountManager.shared.updateSelectedAddress(address)
                }
            }
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(viewModel: .init())
    }
}
