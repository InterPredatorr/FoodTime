//
//  SearchView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 14.09.23.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var basketManager: BasketManager
    @EnvironmentObject var viewHandler: ViewSelectionManager
    @ObservedObject var viewModel: SearchViewModel
    @State var requestState: ButtonState = .ready
    @State var contentRequestState: ButtonState = .pending
    @State private var presentingSheet = false
    
    var body: some View {
        VStack(spacing: 0) {
            Color.background.frame(height: 0.5)
            SearchBarView()
//            if contentRequestState == .finished {
                contentView
//            } else {
//                pendingView
//            }
            Spacer()
        }
        .background(Color.background.edgesIgnoringSafeArea(.all))
        .onReceive(viewHandler.$searchTab) { _ in
            withAnimation {
                viewModel.arr.shuffle()
            }
        }
        
    }
}

extension SearchView {
    var contentView: some View {
        VStack {
            if !viewHandler.searchText.isEmpty {
                ScrollView(showsIndicators: false) {
                    SearchRestaurantsView(restaurants: $viewModel.arr) {
                        withAnimation {
                            viewHandler.selectedView = .restaurants
                            viewHandler.presentRestaurantDetailView.toggle()
                        }
                    } mealItemTapped: { meal in
                        basketManager.selectedMeal = meal
                        presentingSheet.toggle()
                    }
                    .padding(.all, Constants.screenPadding)
                }
                .animation(.easeInOut)
                .sheet(isPresented: $presentingSheet) {
                    AddNewOrderView {
                        basketManager.addSelectedItem()
                        presentingSheet.toggle()
                    }
                }
            } else {
                SearchEmptyView()
            }
        }
    }
    
    var pendingView: some View {
        Group {
            HStack {
                ForEach(0..<3) { _ in
                    LoadingView(foregroundColor: .mainColor, delay: 1, scale: 0.1, length: 20)
                }
            }
            .padding(.vertical, 10)
            ScrollView(showsIndicators: false) {
                ItemsListSkeletonView(isBigger: false)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            withAnimation { contentRequestState = .ready }
                        }
                    }
                    .padding(.all, Constants.screenPadding)
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: .init())
    }
}
