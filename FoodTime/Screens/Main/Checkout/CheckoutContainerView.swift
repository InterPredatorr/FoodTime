//
//  CheckoutContainerView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 24.09.23.
//

import SwiftUI

struct CheckoutContainerView: View {
    
    @ObservedObject var viewModel: CheckoutViewModel
    
    var body: some View {
        Group {
            switch viewModel.currentView {
            case .checkout:
                CheckoutView(viewModel: viewModel)
            case .confirmation:
                OrderConfirmationView(viewModel: viewModel)
            }
        }
    }
}

struct CheckoutContainerView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutContainerView(viewModel: .init())
    }
}
