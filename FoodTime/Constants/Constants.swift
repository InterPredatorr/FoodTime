//
//  Constants.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 10.09.23.
//

import Combine
import SwiftUI

enum Language: String {
    case en
    case hy
}
var language: Language = .en


struct Constants {
    
    struct RemoteActions {
        static let review = "review_id"
        static let ok = "ok_id"
    }

    static let screenPadding: CGFloat = 16
    static let screenHeight = UIScreen.main.bounds.height
    static let screenWidth = UIScreen.main.bounds.width
    static let cornerRadius = 12.0
    static let privacyPolicyUrl = "https://foodtime.asia/privacy"
    static let termsOfUseUrl = "https://foodtime.asia/terms-and-conditions"
    static let appID = "4fdb58c4-4930-4ced-ac0f-4d2ede6b76e9"
}

struct LocalizedStrings {
    static let add = "add".localized
    static let addItem = "add_item".localized
    static let allTaxes = "all_taxes".localized
    static let appleTitle = "login_apple".localized
    static let back = "back".localized
    static let call = "call".localized
    static let cancel = "cancel".localized
    static let checkout = "checkout".localized
    static let checkoutTitle = "checkout_title".localized
    static let closed = "closed".localized
    static let cost = "cost".localized
    static let delivery = "delivery".localized
    static let deliveryAddress = "delivery_address".localized
    static let deliveryFee = "delivery_fee".localized
    static let deliveryTime = "delivery_time".localized
    static let deliveryNote = "delivery_note".localized
    static let facebookTitle = "login_facebook".localized
    static let googleTitle = "sign_in_google".localized
    static let hyperlinkText = "hyperlink_text".localized
    static let login = "login".localized
    static let menuItems = "menu_items".localized
    static let minOrder = "min_order".localized
    static let myInfo = "my_info".localized
    static let myPhone = "my_phone".localized
    static let orderHistory = "order_history".localized
    static let orderSummary = "order_summary".localized
    static let orderType = "order_type".localized
    static let paymentDetailsTitle = "payment_details_title".localized
    static let paymentMethod = "payment_method".localized
    static let pleaseCheck = "please_check".localized
    static let privacyPolicy = "privacy_policy".localized
    static let quantity = "quantity".localized
    static let reorder = "reorder".localized
    static let register = "register".localized
    static let reviews = "reviews_2".localized
    static let specialInstruction = "special_instruction".localized
    static let sst = "sst".localized
    static let subtotal = "subtotal".localized
    static let termsOfUse = "terms_of_use".localized
    static let total = "total".localized
    static let updateOrder = "update_order".localized
    static let verified = "verified".localized
    static let placeOrder = "place_order".localized
    static let voucher = "voucher".localized
    static let voucherCode = "voucher_code".localized
    static let redeem = "redeem".localized
    static let invalidPromo = "invalid_promo".localized
    static let vendorName = "vendor_name".localized
    static let awaitingConfirmation = "awaiting_confirmation".localized
    static let estimatedTime = "estimated_time".localized
    static let home = "home".localized
    static let orderConfirmationTitle = "order_confirmation_title".localized
    static let orderDetails = "order_details".localized
    static let orderNumber = "order_number".localized
    static let restaurant = "restaurant".localized
    static let thanksForOrder = "thanks_for_order".localized
    static let transactionTime = "transaction_time".localized
    static let viewOrder = "view_order".localized
    static let willGetNotified = "will_get_notified".localized
    static let review = "review".localized
    static let review2 = "review_2".localized
    static let canEarn = "can_earn".localized
    static let myReviewTitle = "my_review_title".localized
    static let vendor = "vendor".localized
    static let post = "post".localized
    static let items = "items".localized
    static let reviewPlaceholder = "review_placeholder".localized
    static let addNewOrderTitle = "add_new_order_title".localized
    static let itemChoices = "item_choices".localized
    static let addons = "addons".localized
    static let ok = "Ok".localized
    static let messagePlaceholder = "message_placeholder".localized
}



































