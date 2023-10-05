//
//  BasketView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 15.09.23.
//

import SwiftUI

struct BasketView: View {
    
    @EnvironmentObject var viewHandler: ViewSelectionManager
    @EnvironmentObject var basketManager: BasketManager
    @State var requestState: ButtonState = .ready
    let config = SettingsManager.shared.screens.myBasket
    @State var presentingSheet = false
    
    var body: some View {
        VStack {
            ContentHeaderView(title: config.title.localized)
            if !basketManager.items.isEmpty {
                contentView
            } else {
                emptyView
            }
        }
        .rootViewSetup()
    }
}

extension BasketView {
    var contentView: some View {
        VStack {
            basketContent
            Spacer()
            ElevatedCard(requestState: requestState) {
                bottomTab
            }
        }
        .padding(.horizontal, Constants.screenPadding)
        .rootViewSetup()
        .sheet(isPresented: $presentingSheet) {
            AddNewOrderView { presentingSheet.toggle() }
        }
    }
    
    var emptyView: some View {
        MyBasketEmptyView {
            withAnimation {
                viewHandler.selectedView = .restaurants
                viewHandler.presentRestaurantDetailView = true
            }
        }
    }
}

extension BasketView {
    
    var basketContent: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ForEach($basketManager.items) { item in
                    BasketItemView(item: item) {
                        basketManager.removeItem(item.wrappedValue)
                    }
                    .onTapGesture { presentingSheet.toggle() }
                }
            }
        }
    }
    
    var bottomTab: some View {
        
        return VStack(alignment: .leading, spacing: 10) {
            Text(LocalizedStrings.subtotal)
                .fontWeight(.bold) +
            Text("RM " + basketManager.subtotal)
            Text(LocalizedStrings.deliveryFee)
                .fontWeight(.bold) +
            Text("RM " + basketManager.deliveryFee.removeZerosFromEnd())
            HStack {
                ButtonView(title: LocalizedStrings.addItem, buttonColor: .mainGreen) {
                    withAnimation {
                        viewHandler.presentRestaurantDetailView = true
                        viewHandler.selectedView = .restaurants
                    }
                }
                .fixedSize()
                StateableButtonView(title: buttonTitle, buttonColor: .mainColor, buttonState: $requestState) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        withAnimation {
                            viewHandler.selectedView = .checkout
                            requestState = .ready
                        }
                    }
                }
                Spacer()
            }
        }
        .font(.system(size: 20))
    }
    
    var buttonTitle: String {
        LocalizedStrings.checkout + " (RM \(basketManager.subtotalWithDeliveryFee))"
    }
}

struct BasketItemView: View {
    
    private let imageLenght = 25.0
    @Binding var item: MealItemInfo
    let deleteAction: () -> Void
    
    var body: some View {
        ElevatedCard(padding: 0) {
            HStack {
                Image(item.imageURL)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .cornerRadius(Constants.cornerRadius)
                VStack(alignment: .leading) {
                    Text(item.title.localized)
                    Spacer()
                    StepperView(count: $item.count)
                }
                .padding(.vertical, 5)
                Spacer()
                VStack(alignment: .trailing) {
                    Button {
                        withAnimation { deleteAction() }
                    } label: {
                        Image(Images.delete)
                            .resizable()
                            .frame(width: imageLenght, height: imageLenght)
                            .padding(.all, 5)
                            .background(Color.mainGrayLight)
                            .cornerRadius(Constants.cornerRadius)
                            .foregroundColor(.textPrimary)
                    }
                    Text("RM \(item.subtotal.removeZerosFromEnd())")
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding([.top, .trailing], 5)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 100)
        }
        .padding(.all, 5)
    }
}

struct StepperView: View {
    
    enum LastStep {
        case plus
        case minus
        case none
    }
    
    @Binding var count: Int
    @State private var lastStep: LastStep = .none
    
    var body: some View {
        HStack {
            stepperButton(current: .minus)
            Text(String(count))
            stepperButton(current: .plus)
            Spacer()
        }
    }
    
    
    func stepperButton(current: LastStep) -> some View {
        ButtonView(title: current == .minus ? "- " : "+ ",
                   buttonColor: lastStep == current ? .mainColorDark : .mainGrayLight,
                   foregroundColor: lastStep == current ? .mainWhite : .textPrimary,
                   height: 30) {
            withAnimation {
                if current == .minus {
                    if count > 1 { count -= 1 }
                } else {
                    if count < 20 { count += 1 }
                }
                lastStep = current
            }
        }
        .aspectRatio(1, contentMode: .fit)
        .fixedSize()
    }
    
}

struct BasketView_Previews: PreviewProvider {
    static var previews: some View {
        BasketView()
    }
}
