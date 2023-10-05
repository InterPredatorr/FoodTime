//
//  TabsView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 11.09.23.
//

import SwiftUI

struct TabsView: View {
    @State private var currentTab = ""
    let items: [String]
    let tabChangedAction: (String) -> Void
    
    init(items: [String], tabChangedAction: @escaping (String) -> Void) {
        self.currentTab = items.isEmpty ? "" : items[0]
        self.items = items
        self.tabChangedAction = tabChangedAction
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .top, spacing: 5) {
                ForEach(items, id: \.self) { name in
                    NavigationBarItemView(isSelected: currentTab == name) {
                        Text(name)
                    } tapped: {
                        withAnimation {
                            currentTab = name
                            tabChangedAction(name)
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .background(Color.mainWhite)
        .frame(height: 60)
        .padding(.horizontal, -8)
    }
}



struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantsView(viewModel: .init(selectedRegionTitle: ""))
    }
}
