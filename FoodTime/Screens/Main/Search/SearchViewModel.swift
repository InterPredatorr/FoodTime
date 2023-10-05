//
//  SearchViewModel.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 19.09.23.
//

import Foundation

enum SearchType: String, CaseIterable {
    case restaurants
    case meals
    case cuisines
}

class SearchViewModel: ObservableObject {
    
    @Published var arr: [RestaurantItemInfo] =
    [RestaurantItemInfo(imageURL: "restaurant1", title: "AlKhaemah",
                        type: "Arabic", minOrder: "RM15",
                        cost: "RM1", duration: "45min", rating: 4.5),
     RestaurantItemInfo(imageURL: "restaurant2", title: "Baytana",
                        type: "Yemeni", minOrder: "RM10",
                        cost: "RM2", duration: "60min", rating: 3),
     RestaurantItemInfo(imageURL: "restaurant1", title: "AlKhaemah",
                        type: "Arabic", minOrder: "RM15",
                        cost: "RM1", duration: "45min", rating: 4.5),
     RestaurantItemInfo(imageURL: "restaurant2", title: "Baytana",
                        type: "yemeni", minOrder: "RM10",
                        cost: "RM2", duration: "60min", rating: 3)]
    
    init() {
        arr = arr.map {
            var tmp = $0
            tmp.meals = [.init(imageURL: "mealImage",
                               title: "Arabian Jelly - جلي عربي",
                               description: "", cost: 5.25),
                         .init(imageURL: "mealImage",
                               title: "Flavored Malt Drinks - شراب الشعير",
                               description: "", cost: 6.5)]
            return tmp
        }
    }
}
