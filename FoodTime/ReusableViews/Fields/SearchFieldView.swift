//
//  SearchFieldView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 12.09.23.
//

import SwiftUI

struct SearchFieldView: View {
    
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        ZStack {
            TextFieldView(text: $text, config: .init(title: "", placeholder: placeholder), cornerRadius: 28,
                          background: .mainWhite, padding: 50, height: 60)
                .customShadow()
            HStack {
                Image(systemName: Images.search)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(.textPrimary)
                Spacer()
            }
            .padding(.horizontal, 16)
        }
        .foregroundColor(.textPrimary)
        .padding(.horizontal)
    }
}

struct RestaurantsView_Previews1: PreviewProvider {
    static var previews: some View {
        RestaurantsView(viewModel: .init(selectedRegionTitle: ""))
    }
}
