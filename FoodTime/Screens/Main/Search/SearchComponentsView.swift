//
//  SearchComponentsView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 23.09.23.
//

import SwiftUI

struct SearchRestaurantsView: View {
    
    @EnvironmentObject var viewHandler: ViewSelectionManager
    @Binding var restaurants: [RestaurantItemInfo]
    let restaurantItemTapped: () -> Void
    let mealItemTapped: (MealItemInfo) -> Void
    
    var body: some View {
        VStack {
            ForEach($restaurants) { content in
                if viewHandler.searchTab == .meals {
                    RestaurantMealsCardView(itemInfo: content) {
                        restaurantItemTapped()
                    } mealItemTapped: { meal in
                        mealItemTapped(meal)
                    }
                } else {
                    RestaurantItemView(itemInfo: content)
                        .onTapGesture {
                            restaurantItemTapped()
                        }
                }
            }
            Spacer()
        }
    }
}

struct RestaurantMealsCardView: View {

    @Binding var itemInfo: RestaurantItemInfo
    let restaurantItemTapped: () -> Void
    let mealItemTapped: (MealItemInfo) -> Void
    
    var body: some View {
        ElevatedCard {
            VStack(alignment: .leading) {
                RestaurantInfoCardView(itemInfo: $itemInfo)
                Text(LocalizedStrings.menuItems)
                    .fontWeight(.bold)
                    .foregroundColor(.mainColorDark)
                Divider()
                ForEach($itemInfo.meals) { meal in
                    MealHorizontalItemView(meal: meal)
                        .onTapGesture {
                            withAnimation {
                                mealItemTapped(meal.wrappedValue)
                            }
                        }
                }
            }
            .onTapGesture {
                withAnimation {
                    restaurantItemTapped()
                }
            }
        }
        .padding(.all, 5)

    }
}
