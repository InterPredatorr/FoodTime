//
//  RestaurantComponentViews.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 22.09.23.
//

import SwiftUI

struct RestaurantItemView: View {
    
    @Binding var itemInfo: RestaurantItemInfo
    
    var body: some View {
        ElevatedCard {
            RestaurantInfoCardView(itemInfo: $itemInfo)
        }
        .padding(.all, 5)
    }
}


struct RestaurantInfoCardView: View {
    
    @Binding var itemInfo: RestaurantItemInfo
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            RestaurantImageView(image: itemInfo.imageURL)
            VStack(alignment: .leading, spacing: 8) {
                reusableText(text: itemInfo.title,
                             font: .system(size: 16, weight: .bold))
                reusableText(text: itemInfo.type,
                             color: .textSecondary)
                reusableText(text: LocalizedStrings.minOrder + itemInfo.minOrder,
                             color: .textSecondary)
                HStack {
                    Image(Images.delivery)
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.textPrimary)
                    reusableText(text: itemInfo.cost,
                                 font: .system(size: 14, weight: .semibold))
                    reusableText(text: "\(itemInfo.duration)", color: .textSecondary)
                }
            }
            Spacer()
            RoundedView {
                HStack(spacing: 2) {
                    Image(systemName: Images.starFilled)
                        .foregroundColor(.mainYellow)
                    Text(String(itemInfo.rating.toString))
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(.white)
                }
            }
        }
        .frame(height: 100)
    }
    
    func reusableText(text: String, font: Font = .system(size: 12, weight: .regular),
                      color: Color = .textPrimary) -> some View {
        Text(text.localized)
            .foregroundColor(color)
            .font(font)
    }
}

struct RestaurantImageView: View {
    
    let image: String
    let overlayImages = ["busy", "closed"] //<- for testing
    let cornerRadius = 12.0

    var body: some View {
        ZStack {
            Image(image)
                .resizable()
                .cornerRadius(cornerRadius)
            Image(overlayImages.randomElement()!)
                .resizable()
                .cornerRadius(cornerRadius)
        }
        .aspectRatio(contentMode: .fit)
    }
}
