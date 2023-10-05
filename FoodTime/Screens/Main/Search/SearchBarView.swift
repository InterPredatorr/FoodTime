//
//  SearchBarView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 14.09.23.
//

import SwiftUI

struct SearchBarView: View {
    
    @EnvironmentObject var viewHandler: ViewSelectionManager
    @State var selectedTab: SearchType = .restaurants
    private let searchFieldHeight = 45.0
    let config = SettingsManager.shared.screens.search.bar
    
    var body: some View {
        VStack(spacing: 20) {
            searchField
            filters
        }
        .padding(.all)
        .foregroundColor(.mainWhite)
        .frame(height: viewHandler.presentingSearch ? 160 : 0)
        .background(Color.mainColor)
        .cornerRadius(28, corners: [.bottomLeft, .bottomRight])
        .opacity(viewHandler.presentingSearch ? 1 : 0)
    }
}

extension SearchBarView {
    var searchField: some View {
        HStack(spacing: 10) {
            TextFieldView(text: $viewHandler.searchText,
                          config: .init(title: "", placeholder: config.placeholder),
                          cornerRadius: 20,
                          background: .mainWhite,
                          height: searchFieldHeight)
            Button {
                withAnimation { viewHandler.selectedView = .search }
            } label: {
                Image(systemName: Images.search)
                    .frame(width: searchFieldHeight,
                           height: searchFieldHeight)
                    .background(Color.mainWhite)
                    .foregroundColor(.textPrimary)
                    .cornerRadius(20)
            }
        }
    }
    
    var filters: some View {
        Group {
            HStack {
                Text(config.searchIn.localized)
                    .fontWeight(.regular)
                if !viewHandler.recentlySearchedAreas.isEmpty {
                    Text(viewHandler.recentlySearchedAreas.first!)
                        .underline()
                        .fontWeight(.semibold)
                        .onTapGesture { viewHandler.selectedView = .changeArea }
                }
                Spacer()
            }
            HStack(alignment: .top, spacing: 10) {
                Text(config.searchBy.localized)
                    .fixedSize()
                ForEach(SearchType.allCases, id: \.self) { tab in
                    VStack(spacing: 2) {
                        Text(tab.rawValue.capitalized)
                            .fontWeight(.semibold)
                        Rectangle()
                            .frame(height: 2)
                            .foregroundColor(tab == selectedTab ? .white : .mainColor)
                    }
                    .fixedSize()
                    .onTapGesture {
                        viewHandler.searchTab = tab
                        withAnimation { selectedTab = tab }
                    }
                }
                Spacer()
            }
            .onAppear {
                selectedTab = viewHandler.searchTab
            }
        }
        .foregroundColor(.white)
    }
}

struct _Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView()
    }
}
