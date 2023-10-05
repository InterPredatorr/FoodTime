//
//  RatingSummaryView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 16.09.23.
//

import SwiftUI

struct RatingSummaryView: View {
    
    let info: ReviewsInfo
    
    var body: some View {
        HStack(spacing: 30) {
            VStack(alignment: .leading, spacing: 10) {
                TitleView(title: info.rating.removeZerosFromEnd(), fontSize: 50)
                StarsView(rating: info.rating)
                Text(String(info.userReviews.count) + LocalizedStrings.reviews)
            }
            VStack(spacing: 2) {
                ratingView(index: 5, count: info.ratingCount5)
                ratingView(index: 4, count: info.ratingCount4)
                ratingView(index: 3, count: info.ratingCount3)
                ratingView(index: 2, count: info.ratingCount2)
                ratingView(index: 1, count: info.ratingCount1)
            }
        }
        .fixedSize()
    }
    
    func ratingView(index: Int, count: Int) -> some View {
        
        let totalWidth: CGFloat = 100
        
        return HStack {
            Text(String(index))
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.mainGrayLight)
                    .frame(width: totalWidth, height: 10)
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.mainColor)
                    .frame(width: totalWidth * CGFloat(count) / CGFloat(info.reviewsCount),
                           height: 10)
            }
        }
    }
    
}

struct RatingSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        RatingSummaryView(info: .init(rating: 3.5, reviewsCount: 5, ratingCount1: 4, ratingCount2: 3, ratingCount3: 2, ratingCount4: 1, ratingCount5: 1, userReviews: []))
    }
}
