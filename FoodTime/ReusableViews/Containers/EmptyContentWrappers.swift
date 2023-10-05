//
//  EmptyContentWrappers.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 20.09.23.
//

import SwiftUI

struct MyFavoritesEmptyView: View {
    
    let config = SettingsManager.shared.screens.myFavorites.empty
    let buttonTapped: () -> Void
    
    var body: some View {
        ElevatedCard {
            VStack(spacing: 30) {
                Image(config.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text(config.description.localized)
                    .font(.system(size: 24))
                    .foregroundColor(.textSecondary)
                    .minimumScaleFactor(0.5)
                ButtonView(title: config.button.localized, buttonColor: .mainGreen) {
                    buttonTapped()
                }
            }
        }
        .padding(.all, Constants.screenPadding)
    }
}

struct MyBasketEmptyView: View {
    
    let config = SettingsManager.shared.screens.myBasket.empty
    let buttonTapped: () -> Void
    
    var body: some View {
        VStack {
            ElevatedCard {
                VStack(spacing: 30) {
                    Text(config.description.localized)
                        .font(.system(size: 24))
                        .foregroundColor(.textSecondary)
                        .minimumScaleFactor(0.5)
                    ButtonView(title: config.button.localized, buttonColor: .mainGreen) {
                        buttonTapped()
                    }
                }
            }
            .padding(.all, Constants.screenPadding)
            Spacer()
        }
    }
}

struct SearchEmptyView: View {
    
    let config = SettingsManager.shared.screens.search.empty
    
    var body: some View {
        ElevatedCard {
            VStack(spacing: 30) {
                Image(config.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text(config.description)
                    .font(.system(size: 24))
                    .foregroundColor(.textSecondary)
                    .minimumScaleFactor(0.5)
            }
        }
        .padding(.all, Constants.screenPadding)
    }
}
