//
//  StarsView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 16.09.23.
//

import SwiftUI

struct StarsView: View {
    
    @State var rating: Double
    var length: CGFloat? = nil
    var allowedToChange = false
    var body: some View {
        HStack {
            ForEach(1..<6) { i in
                Image(systemName: Images.starFilled)
                    .resizable()
                    .foregroundColor(Double(i) <= rating ? .mainYellow : .mainGrayDark)
                    .frame(width: length ?? 25, height: length ?? 25)
                    .onTapGesture {
                        if allowedToChange {
                            withAnimation(.smooth) { rating = Double(i) }
                        }
                    }
            }
        }
    }
}

struct StarsView_Previews: PreviewProvider {
    static var previews: some View {
        StarsView(rating: 3.5)
    }
}
