//
//  SkeletonViews.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 19.09.23.
//

import SwiftUI

struct MainSkeletonView: View {
    var body: some View {
        VStack(spacing: 20) {
            ElevatedCard {
                skeletons(.horizontal, count: 1, lenght: 200)
            }
            ElevatedCard {
                skeletons(.horizontal, count: 3, lenght: 150)
            }
            ElevatedCard {
                skeletons(.horizontal, count: 5, lenght: 30)
            }
            VStack(spacing: 20) {
                ForEach(0..<4) { _ in
                    ElevatedCard {
                        HStack {
                            skeletons(.horizontal, count: 1, lenght: 100)
                                .aspectRatio(1, contentMode: .fit)
                            Spacer()
                            skeletons(.vertical, count: 3, lenght: 200)
                        }
                    }
                }
            }
            Spacer()
            
        }
    }
}

struct ListSkeletonView: View {
    
    let count: Int
    
    var body: some View {
        ElevatedCard {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    skeletons(.vertical, count: 1, lenght: 200)
                        .frame(height: 40)
                    ForEach(0..<count, id: \.self) { _ in
                        skeletons(.horizontal, count: 1, lenght: 30)
                    }
                }
            }
        }
    }
}

struct PopUpSkeletonView: View {

    var body: some View {
        ElevatedCard {
            VStack(spacing: 20) {
                Spacer()
                skeletons(.horizontal, count: 1, lenght: 200, cornerRadius: 20)
                skeletons(.horizontal, count: 3, lenght: 50, cornerRadius: 20)
                skeletons(.horizontal, count: 1, lenght: 60)
                    .cornerRadius(30)
                skeletons(.horizontal, count: 1, lenght: 120)
                    .cornerRadius(40)
                skeletons(.horizontal, count: 1, lenght: 60)
                    .cornerRadius(30)
                Spacer()
            }
        }
    }
}

struct RestaurantCardSkeletonView: View {
    
    var body: some View {
        HStack {
            skeletons(.horizontal, count: 1, lenght: 100)
                .aspectRatio(1, contentMode: .fit)
            Spacer()
            skeletons(.vertical, count: 3, lenght: 200)
        }
    }
}

struct ItemsListSkeletonView: View {
    
    var isBigger: Bool = true
    
    var body: some View {
        VStack(spacing: 20) {
            ForEach(0..<5) { _ in
                ElevatedCard {
                    VStack {
                        RestaurantCardSkeletonView()
                        Spacer().frame(height: 20)
                        if isBigger {
                            skeletons(.horizontal, count: 3, lenght: 30)
                        }
                    }
                }
            }
        }
    }
}

struct KeyValuePairSkeletonView: View {
    
    let count: Int

    var body: some View {
        VStack {
            ElevatedCard {
                ScrollView(showsIndicators: false) {
                    HStack {
                        VStack(spacing: 15) {
                            ForEach(0..<count, id: \.self) { _ in
                                skeletons(.horizontal, count: 1, lenght: 30)
                            }
                        }
                        .frame(width: 100)
                        
                        VStack(spacing: 15) {
                            ForEach(0..<count, id: \.self) { _ in
                                skeletons(.horizontal, count: 1, lenght: 30)
                            }
                        }
                    }
                }
            }
            .fixedSize(h: false)
            Spacer()
        }
    }
}

struct KeyValuePairSkeletonView_Previews: PreviewProvider {
    static var previews: some View {
        KeyValuePairSkeletonView(count: 10)
    }
}
