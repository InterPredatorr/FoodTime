//
//  CheckoutViewModel.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 23.09.23.
//

import Foundation

class CheckoutViewModel: ObservableObject {
    
    enum CurrentView {
        case checkout
        case confirmation
    }
    
    struct RequestStates {
        var redeem: ButtonState = .ready
        var placeOrder: ButtonState = .ready
        var content: RequestState = .pending
    }
    @Published var currentView: CurrentView = .checkout
    @Published var requestStates = RequestStates()
    @Published var orderTypes: [String: Bool] = ["Delivery": true]
    @Published var paymentMethods: [String: Bool] = ["Cash": true, "Online": false]
    @Published var checkoutItemInfo = CheckoutItemInfo(orderType: "Delivery",
                                            myInfo: .init(phone: "+37494610421", deliveryTime: "30min",
                                                          vendorName: "Sevak Tadevosyan"),
                                            deliveryAddress: .init(addressName: "", address: ""),
                                            deliveryNote: "",
                                            voucher: "",
                                            paymentMethod: "", subtotal: 0.1)
    
    func updateOrderType(with type: String) {
        checkoutItemInfo.orderType = type
        orderTypes.keys.forEach { key in
            orderTypes[key] = type == key
        }
    }
    
    func updatePaymentMethod(with method: String) {
        checkoutItemInfo.paymentMethod = method
        paymentMethods.keys.forEach { key in
            paymentMethods[key] = method == key
        }
    }
}
