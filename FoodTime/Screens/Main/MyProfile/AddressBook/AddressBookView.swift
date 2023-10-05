//
//  AddressBookView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 13.09.23.
//

import SwiftUI

struct AddressBookView: View {
    
    @EnvironmentObject var viewHandler: ViewSelectionManager
    @ObservedObject var viewModel: MyProfileViewModel
    @State var presentSheet = false
    let config = SettingsManager.shared.screens.addressBook
    
    var body: some View {
        contentView
    }
}

extension AddressBookView {
    var contentView: some View {
        VStack {
            ContentHeaderView(title: config.title.localized)
            ScrollView(showsIndicators: false) {
                ForEach(AccountManager.shared.myProfileInfo.addressBook) { addressInfo in
                    AddressBookItemView(addressInfo: addressInfo) {
                        withAnimation {
                            AccountManager.shared.deleteFromAddressBook(addressInfo)
                        }
                    }
                    .padding(.horizontal, 10)
                    Spacer().frame(height: 20)
                }
                .padding(.vertical)
            }
            HStack(spacing: 15) {
                ButtonView(title: config.addAddressTitle.localized, buttonColor: .mainGreen) {
                    presentSheet.toggle()
                }
                .sheet(isPresented: $presentSheet) {
                    AddNewAddressView { newAddress in
                        AccountManager.shared.addNewAddress(newAddress)
                        presentSheet.toggle()
                    }
                }
                ButtonView(title: config.backTitle.localized, buttonColor: .mainColor) {
                    withAnimation { viewModel.returnToMain() }
                }
            }
        }
        .padding(.horizontal, Constants.screenPadding)
        .rootViewSetup()
    }
}

struct AddressBookItemView: View {
    
    let addressInfo: AddressInfo
    @State private var presentSheet = false
    let deleteTitle = SettingsManager.shared.screens.addressBook.deleteTitle.localized
    let buttonTapped: () -> Void
    
    var body: some View {
        ElevatedCard(padding: 10) {
            VStack(alignment: .leading) {
                HStack {
                    if addressInfo.isDefault {
                        Image(systemName: Images.starFilled)
                            .foregroundColor(.mainYellow)
                    }
                    Text(addressInfo.addressName)
                        .foregroundColor(.mainGreen)
                    Spacer()
                }
                Text(addressInfo.address)
                    .foregroundColor(.textPrimary)
                    .lineLimit(2)
                ButtonView(title: deleteTitle, buttonColor: .mainColor) {
                    buttonTapped()
                }
                .fixedSize(v: true)
            }
        }
    }
}

struct AddressBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddressBookView(viewModel: .init() { })
    }
}
