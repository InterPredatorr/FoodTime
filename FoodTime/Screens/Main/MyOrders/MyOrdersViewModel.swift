//
//  MyOrdersViewModel.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 23.09.23.
//

import Foundation

struct MyOrderInfo: Identifiable {
    var id = UUID()
    var imageURL: String
    var title: String
    var orderID: String
    var status: String
    var isMissingReview = false
    var date: String
    var cost: Double
}

class MyOrdersViewModel: ObservableObject {
    
    enum Selectedview {
        case list
        case detail(selectedOrder: MyOrderInfo)
    }
    
    struct RequestStates {
        var list: RequestState = .pending
        var orderInfo: RequestState = .pending
    }
    
    @Published var requestStates = RequestStates()
    @Published var selectedView: Selectedview = .list
    
    @Published var orderTypes: [String: Bool] = ["Delivery": true, "Takeaway": false, "Dine in": false]
    @Published var paymentMethods: [String: Bool] = ["Cash": true, "Online": false]
    
    @Published var orders: [MyOrderInfo] = [.init(imageURL: "appIcon",
                                       title: "FoodTime test",
                                       orderID: "FT-3242134",
                                       status: "DELIVERED",
                                       isMissingReview: true,
                                       date: Date().description,
                                       cost: 20),
                                 .init(imageURL: "appIcon",
                                       title: "FoodTime test",
                                       orderID: "FT-3242134",
                                       status: "SHIPPED",
                                       date: Date().description,
                                       cost: 20)]
}
