//
//  AddNewOrderView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 17.09.23.
//

import SwiftUI

struct AddNewOrderView: View {
    
    @EnvironmentObject var basketManager: BasketManager
    @EnvironmentObject var viewHandler: ViewSelectionManager
    @State var requestState: ButtonState = .ready
    @State private var contentRequestState: ButtonState = .pending
    @State var instructions: String = ""
    let completion: () -> Void
    
    var body: some View {
        VStack {
            ContentHeaderView(title: LocalizedStrings.addNewOrderTitle)
            if contentRequestState == .ready {
                contentView
            } else {
                pendingView
            }
        }
    }
}

extension AddNewOrderView {
    var contentView: some View {
        ElevatedCard(requestState: requestState, padding: 0, backgroundColor: Color.mainWhite) {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 15) {
                    header
                    quantity
                    itemChoices
                    addons
                    specialInstruction
                    buttons
                    Spacer()
                }
                .padding(.all, 5)
            }
        }
        .padding(.all, 5)
    }
    
    var pendingView: some View {
        PopUpSkeletonView()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    withAnimation { contentRequestState = .ready }
                }
            }
    }
}

extension AddNewOrderView {
    var header: some View {
        VStack {
            Image(basketManager.selectedMeal.imageURL)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 10)
            Text(title)
                .font(.system(size: 26, weight: .bold))
        }
    }
    
    var title: String {
        let cost = basketManager.selectedMeal.cost.removeZerosFromEnd()
        return basketManager.selectedMeal.title.localized + " (RM \(cost))"
    }
    
    var quantity: some View {
        sectionItemView(title: LocalizedStrings.quantity,
                        count: $basketManager.selectedMeal.count,
                        cost: subtotal.removeZerosFromEnd(),
                        fontSize: 24,
                        subtotal: basketManager.selectedMeal.subtotal)
    }
    
    var itemChoices: some View {
        Group {
            if !basketManager.selectedMeal.choices.isEmpty {
                sectionTitleView(LocalizedStrings.itemChoices)
                ForEach(basketManager.selectedMeal.choices) { choice in
                    choiceView(choice)
                }
            }
        }
    }
    
    var addons: some View {
        Group {
            if !basketManager.selectedMeal.addons.isEmpty {
                sectionTitleView(LocalizedStrings.addons)
                ForEach($basketManager.selectedMeal.addons) { addon in
                    sectionItemView(title: addon.title.wrappedValue,
                                    count: addon.count,
                                    cost: addon.cost.wrappedValue.removeZerosFromEnd(),
                                    fontSize: 16,
                                    subtotal: addon.subtotal.wrappedValue)
                }
            }
        }
    }
    
    var specialInstruction: some View {
        Group {
            sectionTitleView(LocalizedStrings.specialInstruction)
            textView
        }
    }
    
    var textView: some View {
        TextView(text: $instructions, height: 100)
    }
    
    var buttons: some View {
        VStack {
            ButtonView(title: buttonTitle, buttonColor: .mainGreen, height: 50) {
                basketManager.addSelectedItem()
                completion()
            }
            ButtonView(title: LocalizedStrings.cancel, buttonColor: .mainColor, height: 50) {
                completion()
            }
        }
    }
    
    var buttonTitle: String {
        (basketManager.contains() ? LocalizedStrings.updateOrder : LocalizedStrings.addItem)  + "(RM \(subtotal))"
    }
    
    var subtotal: Double {
        basketManager.selectedMeal.entireCost
    }
    
    func choiceView(_ choice: MealItemInfo.Choice) -> some View {
        ElevatedCard {
            HStack {
                Text(choice.title)
                Spacer()
                Button {
                    basketManager.updateSelectedMealChoices(with: choice.id)
                } label: {
                    Image(systemName: choice.isSelected ? Images.circleFilledInsets : Images.circle)
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundColor(choice.isSelected ? .blue : .textPrimary)
                }
            }
            .onTapGesture { basketManager.updateSelectedMealChoices(with: choice.id) }
            .padding(5)
        }
    }
    
    private func sectionTitleView(_ title: String) -> some View {
        Text(title)
            .font(.system(size: 24, weight: .bold))
            .foregroundColor(.white)
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(Color.mainColor)
            .padding(.horizontal, -10)
    }
    
    func sectionItemView(title: String, count: Binding<Int>, cost: String, fontSize: CGFloat, subtotal: Double) -> some View {
        ElevatedCard(backgroundColor: .mainWhite) {
            HStack {
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.system(size: fontSize, weight: .semibold))
                    StepperView(count: count)
                }
                Spacer()
                Text("RM " + String(subtotal))
                    .font(.system(size: fontSize, weight: .bold))
            }
        }
    }
}

struct AddNewOrderView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewOrderView() { }
    }
}
