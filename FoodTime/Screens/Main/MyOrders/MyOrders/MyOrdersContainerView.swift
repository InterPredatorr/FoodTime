//
//  MyOrdersContainerView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 23.09.23.
//

import SwiftUI

struct MyOrdersContainerView: View {
    
    @ObservedObject var viewModel: MyOrdersViewModel
    
    var body: some View {
        switch viewModel.selectedView {
        case .list:
            MyOrdersView(viewModel: viewModel)
        case let .detail(orderInfo):
            MyOrderDetailView(viewModel: viewModel, orderInfo: orderInfo)
        }
    }
}

struct MyOrdersContainerView_Previews: PreviewProvider {
    static var previews: some View {
        MyOrdersContainerView(viewModel: .init())
    }
}
