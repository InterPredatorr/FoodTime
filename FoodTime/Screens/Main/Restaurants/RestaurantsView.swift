//
//  RestaurantsView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 11.09.23.
//

import SwiftUI

struct RestaurantsView: View {
    
    @EnvironmentObject var viewHandler: ViewSelectionManager
    @ObservedObject var viewModel: RestaurantsViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            if viewHandler.presentRestaurantDetailView {
                RestaurantDetailView(itemInfo: viewModel.mock)
            } else {
                RestaurantsMainView(viewModel: viewModel)
            }
        }
    }
}

struct RestaurantsView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantsView(viewModel: .init(selectedRegionTitle: "Armenia"))
    }
}
