//
//  RestaurantMenuView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 16.09.23.
//

import SwiftUI


struct MealSectionInfo: Identifiable {
    var id = UUID()
    var mealType: String
    var meals: [MealItemInfo]
    var isSelected = false
}

struct RestaurantMenuView: View {
    
    @EnvironmentObject var viewHandler: ViewSelectionManager
    @EnvironmentObject var basketManager: BasketManager
    
    let mealTypes = ["🌟New Meals🌟",
                     "Appetizers - المقبلات",
                     "Sandwiches - الساندويش",
                     "Main Courses - الأطباق الرئيسية"]
    @State private var currentTab = "🌟New Meals🌟"
    @State private var showingPopup = false
    let newMeals: [MealItemInfo] = [.init(imageURL: "mealImage",
                                          title: "Arabian Jelly - جلي عربي",
                                          description: "",
                                          cost: 5.25),
                                    .init(imageURL: "mealImage",
                                          title: "Flavored Malt Drinks - شراب الشعير",
                                          description: "",
                                          cost: 6.5),
                                    .init(imageURL: "mealImage",
                                          title: "Flavored Malt Drinks - شراب الشعير",
                                          description: "",
                                          cost: 6.5)]
    let meals: [MealItemInfo] = []
    @State var mealSections: [MealSectionInfo] = [.init(mealType: "🌟New Meals🌟",
                                                        meals: [.init(imageURL: "mealImage",
                                                                      title: "Arabian Jelly - جلي عربي",
                                                                      description: "", cost: 5.25),
                                                                .init(imageURL: "mealImage",
                                                                      title: "Flavored Malt Drinks - شراب الشعير",
                                                                      description: "", cost: 6.5)]),
                                                  .init(mealType: "Appetizers - المقبلات",
                                                        meals: [.init(imageURL: "mealImage",
                                                                      title: "Arabian Jelly - جلي عربي",
                                                                      description: "", cost: 5.25),
                                                                .init(imageURL: "mealImage",
                                                                      title: "Flavored Malt Drinks - شراب الشعير",
                                                                      description: "", cost: 6.5)]),
                                                  .init(mealType: "Sandwiches - الساندويش",
                                                        meals: [.init(imageURL: "mealImage",
                                                                      title: "Arabian Jelly - جلي عربي",
                                                                      description: "", cost: 5.25),
                                                                .init(imageURL: "mealImage",
                                                                      title: "Flavored Malt Drinks - شراب الشعير",
                                                                      description: "", cost: 6.5)])]
    
    @State private var searchText: String = ""
    @State private var presentingSheet = false

    let config = SettingsManager.shared.screens.restaurants.restaurantDetail.tabs.menu
    var body: some View {
        contentView
            .padding(.all, Constants.screenPadding)
    }
    
    
}

extension RestaurantMenuView {
    var contentView: some View {
        ZStack {
            VStack {
                tabs
                searchBar
                mainContent
                Spacer()
            }
        }
    }
    
    var tabs: some View {
        TabsView(items: mealTypes) { meal in
            currentTab = meal
        }
    }
    
    var searchBar: some View {
        SearchFieldView(placeholder: config.searchPlaceholder, text: $searchText)
    }
    
    var mainContent: some View {
        VStack(alignment: .leading) {
            TitleView(title: "New Meals") // will be removed
                .padding(.horizontal, Constants.screenPadding)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(newMeals) { meal in
                        MealCompactItemView(item: meal)
                            .onTapGesture {
                                basketManager.selectedMeal = meal
                                presentingSheet.toggle()
                            }
                    }
                }
                .padding(.all, Constants.screenPadding)
            }
            VStack {
                ForEach($mealSections) { section in
                    MealSectionView(mealSetionInfo: section, presentingSheet: $presentingSheet)
                }
            }
        }
        .padding(.top, 10)
        .sheet(isPresented: $presentingSheet) {
            AddNewOrderView {
                presentingSheet.toggle()
            }
        }
    }
}

struct MealSectionView: View {
    
    @EnvironmentObject var viewHandler: ViewSelectionManager
    @EnvironmentObject var basketManager: BasketManager
    @Binding var mealSetionInfo: MealSectionInfo
    @Binding var presentingSheet: Bool
    @State private var showingPopup = false
    
    var body: some View {
        ElevatedCard(backgroundColor: mealSetionInfo.isSelected ? Color.mainColor : Color.mainWhite) {
            HStack {
                Text(mealSetionInfo.mealType)
                    
                Spacer()
                Image(systemName: Images.chevronRight)
                    .resizable()
                    .frame(width: 10, height: 20)
                    .cornerRadius(Constants.cornerRadius)
                    .rotationEffect(mealSetionInfo.isSelected ? .degrees(90) : .zero)
                    .foregroundColor(.textPrimary)
            }
            .foregroundColor(mealSetionInfo.isSelected ? Color.mainWhite : Color.textPrimary)
        }
        .onTapGesture {
            withAnimation { mealSetionInfo.isSelected.toggle() }
        }
        if mealSetionInfo.isSelected {
            ForEach($mealSetionInfo.meals) { meal in
                MealHorizontalItemView(meal: meal)
                    .onTapGesture {
                        basketManager.selectedMeal = meal.wrappedValue
                        presentingSheet.toggle()
                    }
            }
        }
    }
}

struct MealHorizontalItemView: View {
    
    let imageLenght = 100.0
    @Binding var meal: MealItemInfo
    
    var body: some View {
        ElevatedCard {
            HStack(alignment: .center) {
                Image(meal.imageURL)
                    .resizable()
                    .frame(width: imageLenght, height: imageLenght)
                VStack(alignment: .leading) {
                    Text(meal.title)
                        .foregroundColor(.textPrimary)
                    Text("RM " + meal.cost.removeZerosFromEnd())
                        .foregroundColor(.mainColor)
                    Spacer()
                }
                .font(.system(size: 20, weight: .semibold))
                Spacer()
                Image(systemName: Images.chevronRight)
                    .resizable()
                    .frame(width: 10, height: 20)
                    .cornerRadius(Constants.cornerRadius)
                    .rotationEffect(.zero)
                    .foregroundColor(.textPrimary)
            }
        }
        
    }
}

struct MealCompactItemView: View {
    
    let item: MealItemInfo
    var ratio: CGFloat? = nil
    var showingCost = true
    
    var body: some View {
        ElevatedCard(padding: 0) {
            ZStack {
                Image(item.imageURL)
                    .resizable()
                    .scaledToFill()
                VStack(alignment: .leading) {
                    if showingCost {
                        RoundedView {
                            Text("RM " + item.cost.removeZerosFromEnd())
                                .foregroundColor(.white)
                        }
                    }
                    Spacer()
                    StrokeText(text: item.title, width: 0.5, color: .textPrimary)
                        .foregroundColor(.mainWhite)
                        .lineLimit(2)
                        .font(.system(size: 16, weight: .bold))
                }
                .padding(.all, showingCost ? 10 : 20)
                Color.black.opacity(0.1)
            }
            .frame(height: 120)
            .aspectRatio(ratio ?? 1, contentMode: .fit)
        }
    }
}


struct RestaurantMenuView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantMenuView()
    }
}
