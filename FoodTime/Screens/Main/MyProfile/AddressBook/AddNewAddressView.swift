//
//  AddNewAddressView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 20.09.23.
//

import SwiftUI

struct AddNewAddressView: View {
    @State var textFieldData: AddressInfo = .init(addressName: "", address: "")
    @State private var checkBoxSelected = false
    let config = SettingsManager.shared.screens.newAddress
    
    let addNewAddressTapped: (AddressInfo) -> Void
    
    var body: some View {
        contentView
    }
}

extension AddNewAddressView {
    var contentView: some View {
        VStack {
            ContentHeaderView(title: config.title.localized)
            ElevatedCard {
                VStack(spacing: 20) {
                    TextFieldView(text: $textFieldData.addressName, config: config.fields.addressName, height: 40)
                    TextFieldView(text: $textFieldData.address, config: config.fields.address, height: 40)
                    TextFieldView(text: $textFieldData.floor, config: config.fields.floor, height: 40)
                    Button {
                        checkBoxSelected.toggle()
                        textFieldData.isDefault = checkBoxSelected
                    } label: {
                        HStack {
                            Image(systemName: checkBoxSelected ? Images.circleFilledInsets : Images.circle)
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text(config.defaultAddress.localized)
                                .foregroundColor(.textPrimary)
                        }
                        .foregroundColor(.textPrimary)
                    }
                }
            }
            .padding(.horizontal, Constants.screenPadding)
            Spacer()
            ButtonView(title: config.createAddress.localized, buttonColor: .mainGreen) {
                addNewAddressTapped(textFieldData)
            }
            .fixedSize()
        }
        .rootViewSetup()
    }
}

struct AddNewAddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewAddressView(addNewAddressTapped: { _ in })
    }
}
