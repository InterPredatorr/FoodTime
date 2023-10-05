//
//  RestaurantsViewModel.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 11.09.23.
//

import Foundation

struct RestaurantDetailInfo {
    let backgroundImage: String
    let mainImage: String
    let title: String
    let rating: Double
    let restaurantType: String
    let openTime: String
    let deliveryFee: String
    let deliveryDuration: String
    let location: String
    let menu: [String: [MealItemInfo]]
    let reviews: ReviewsInfo
    var info: [StringTuple]
    var isFavorite: Bool
}

struct ReviewsInfo {
    let rating: Double
    let reviewsCount: Int
    let ratingCount1: Int
    let ratingCount2: Int
    let ratingCount3: Int
    let ratingCount4: Int
    let ratingCount5: Int
    let userReviews: [UserReviewInfo]
}

struct UserReviewInfo: Identifiable {
    var id = UUID()
    let name: String
    let rating: Double
    let date: String
    let message: String
    let meals: [MealItemInfo] = [.init(imageURL: "mealImage",
                                       title: "Arabian Jelly - جلي عربي",
                                       description: "",
                                       cost: 5.25),
                                 .init(imageURL: "mealImage",
                                       title: "Flavored Malt Drinks - شراب الشعير",
                                       description: "",
                                       cost: 6.5),
                                 .init(imageURL: "mealImage",
                                       title: "Flavored Malt Drinks - شراب الشعير",
                                       description: "",
                                       cost: 6.5)]
}


struct MealItemInfo: Identifiable {
    var id = UUID()
    let imageURL: String
    var title: String
    let description: String
    var count = 1
    let cost: Double
    var choices: [Choice] = [.init(title: "Rice jj (RM 0)", isSelected: true),
                             .init(title: "French Fries ales jublby (RM 0)", isSelected: false)]
    var addons: [Addon] = [.init(title: "Garlic Sauce saill Ago (+ RM 1)", count: 0),
                           .init(title: "Bread is (+ RM 2)", count: 0)]
    var subtotal: Double {
        return cost * Double(count)
    }
    
    var entireCost: Double {
        let addons = addons.reduce(0.0) { $0 + $1.subtotal }
        let choice = choices.first(where: { $0.isSelected })!.cost
        return cost * Double(count) + addons + choice
    }
    
    struct Choice: Identifiable {
        var id = UUID()
        var title: String
        var isSelected: Bool
        let cost = 13.5
        
        var subtotal: Double {
            return cost
        }
    }
    
    struct Addon: Identifiable {
        var id = UUID()
        var title: String
        var count: Int
        var cost = 10.5
        
        var subtotal: Double {
            get {
                return cost * Double(count)
            }
            set { }
        }
    }
}

struct RestaurantItemInfo: Identifiable {
    var id = UUID()
    let imageURL: String
    let title: String
    let type: String
    let minOrder: String
    let cost: String
    let duration: String
    let rating: Double
    var meals: [MealItemInfo] = []
}

class RestaurantsViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    let images = ["test1", "test2", "test3", "test4"]
    var navigationItems: [String] = ["All", "Arabic", "Arabic multi cuisine",
                                     "Asian", "Beverage", "Chinese Muslim", "Italin"]
    let config = SettingsManager.shared.screens.restaurants
    
    var detailKeys: [StringTuple] {
        return config.restaurantDetail.tabs.info.keys.map { .init($0.localized, "test_string") }
    }
    
    @Published var restaurantsMock: [RestaurantItemInfo] = [RestaurantItemInfo(imageURL: "restaurant1", title: "AlKhaemah",
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
    var mock = RestaurantDetailInfo(backgroundImage: "restaurantDetail", mainImage: "appIcon",
                                    title: "Arabic Palace", rating: 3.0,
                                    restaurantType: "Middle Eastern", openTime: "11:00AM - 10:00PM",
                                    deliveryFee: "Free", deliveryDuration: "60mins",
                                    location: "Sungai Chua", menu: [:],
                                    reviews: .init(rating: 3.2, reviewsCount: 10, ratingCount1: 1,
                                                   ratingCount2: 3, ratingCount3: 2, ratingCount4: 3,
                                                   ratingCount5: 5,
                                                   userReviews: [.init(name: "name1",
                                                                       rating: 3.5,
                                                                       date: "\(Date().description)",
                                                                       message: "message1"),
                                                                 .init(name: "name2",
                                                                       rating: 3.5,
                                                                       date: "\(Date().description)",
                                                                       message: "message2")]),
                                    info: [],
                                    isFavorite: true)
    
    @Published var selectedTabRestaurants: [RestaurantItemInfo] = []
    let selectedRegionTitle: String
    var restaurants: [String: [RestaurantItemInfo]] = [:]
    
    init(selectedRegionTitle: String) {
        self.selectedRegionTitle = selectedRegionTitle
        let arr: [RestaurantItemInfo] =
        [RestaurantItemInfo(imageURL: "restaurant1", title: "AlKhaemah", type: "Arabic", minOrder: "RM15",
                            cost: "RM1", duration: "45min", rating: 4.5),
         RestaurantItemInfo(imageURL: "restaurant2", title: "Baytana", type: "Yemeni", minOrder: "RM10",
                            cost: "RM2", duration: "60min", rating: 3),
         RestaurantItemInfo(imageURL: "restaurant1", title: "AlKhaemah", type: "Arabic", minOrder: "RM15",
                            cost: "RM1", duration: "45min", rating: 4.5),
         RestaurantItemInfo(imageURL: "restaurant2", title: "Baytana", type: "yemeni", minOrder: "RM10",
                            cost: "RM2", duration: "60min", rating: 3)
        ]
        selectedTabRestaurants = arr
        navigationItems.forEach { item in
            restaurants[item] = arr.shuffled()
        }
        mock.info = detailKeys
    }
    
    func updateTabContent(with tab: String) {
        if restaurants.keys.contains(tab) {
            selectedTabRestaurants = restaurants[tab]!.shuffled()
        }
    }
}
