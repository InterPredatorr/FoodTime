//
//  SettingsManager.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 10.09.23.
//

import Foundation

struct AppSettings: Codable {
    let screens: Screens
}

struct Screens: Codable {
    let search: SearchConfig
    let myBasket: MyBasketConfig
    let main: MainConfig
    let login: LoginConfig
    let myProfile: MyProfileConfig
    let addressBook: AddressBookConfig
    let newAddress: NewAddressConfig
    let restaurants: RestaurantsConfig
    let myFavorites: MyFavoritesConfig
    let myOrders: MyOrdersConfig
    let changeArea: ChangeAreaConfig
    let feedback: FeedbackConfig
    let support: SupportConfig
}

struct SearchConfig: Codable {
    let bar: SearchBarConfig
    let empty: EmptyConfig
    
    struct SearchBarConfig: Codable {
        let placeholder: String
        let searchIn: String
        let searchBy: String
    }
}

struct MyBasketConfig: Codable {
    let title: String
    let empty: EmptyConfig
}

struct ChangeAreaConfig: Codable {
    let title: String
    let subtitle: String
    let searchPlaceholder: String
}

struct MyOrdersConfig: Codable {
    let title: String
    let empty: EmptyConfig
}

struct MyFavoritesConfig: Codable {
    let title: String
    let empty: EmptyConfig
}

struct LoginConfig: Codable {
    let hyperlink: Hyperlink
    let signIn: SignIn
    let signUp: SignUp
    let forgotPassword: ForgotPassword
    
    struct SignIn: Codable {
        let title: String
        let description: String
        let forgotPasswordTitle: String
        let createAccountTitle: String
        let loginTitle: String
        let fields: Fields
        
        struct Fields: Codable {
            let email: TextFieldConfig
            let password: TextFieldConfig
        }
    }
    
    struct SignUp: Codable {
        let title: String
        let description: String
        let haveAccountMessage: String
        let fields: Fields
        
        struct Fields: Codable {
            let fullname: TextFieldConfig
            let email: TextFieldConfig
            let phoneNumber: TextFieldConfig
            let password: TextFieldConfig
        }
    }
    
    struct ForgotPassword: Codable {
        let title: String
        let description: String
        let buttonTitle: String
        let fields: Fields
        
        struct Fields: Codable {
            let email: TextFieldConfig
        }
    }
    
    struct Hyperlink: Codable {
        let text: String
        let links: [Link]
        
        struct Link: Codable {
            let title: String
            let link: String
        }
    }
    
    
}

struct RestaurantsConfig: Codable {
    let title: String
    let subtitle: String
    let searchPlaceholder: String
    let restaurantDetail: Detail
    
    struct Detail: Codable {
        let main: Main
        let tabs: Tabs
    }
    
    struct Main: Codable {
        let workTimeImage: String
        let deliveryTimeImage: String
        let locationImage: String
    }
    
    struct Tabs: Codable {
        let menu: Menu
        let reviews: Reviews
        let info: Info
        
        struct Menu: Codable {
            let tabName: String
            let searchPlaceholder: String
        }
        
        struct Reviews: Codable {
            let tabName: String
            let summary: String
        }
        
        struct Info: Codable {
            let tabName: String
            let title: String
            let keys: [String]
        }
    }
}

struct MyProfileConfig: Codable {
    let title: String
    let fields: Fields
    let buttons: Buttons
    let verifyPhone: VerifyPhone
    let changePassword: ChangePassword
    
    struct Fields: Codable {
        let fullname: TextFieldConfig
        let email: TextFieldConfig
        let contactNumber: TextFieldConfig
    }
    
    struct Buttons: Codable {
        let verify: String
        let addressBook: String
        let changePassword: String
        let logout: String
    }
    
    struct VerifyPhone: Codable {
        let title: String
        let description1: String
        let description2: String
        let fields: Fields
        let requestOTPTitle: String
        let verifyTitle: String
        
        struct Fields: Codable {
            let otp: TextFieldConfig
        }
    }
    
    struct ChangePassword: Codable {
        let title: String
        let fields: Fields
        let buttonTitle: String
        
        struct Fields: Codable {
            let currentPassword: TextFieldConfig
            let newPassword: TextFieldConfig
            let confirmPassword: TextFieldConfig
        }
    }
}

struct AddressBookConfig: Codable {
    let title: String
    let addAddressTitle: String
    let backTitle: String
    let deleteTitle: String
}

struct NewAddressConfig: Codable {
    let title: String
    let defaultAddress: String
    let createAddress: String
    let fields: Fields
    
    struct Fields: Codable {
        let addressName: TextFieldConfig
        let address: TextFieldConfig
        let floor: TextFieldConfig
    }
}

struct MainConfig: Codable {
    let sideMenuImage: String
    let mainImage: String
    let basketImage: String
    let searchImage: String
    let sideMenu: SideMenuConfig
}

struct SideMenuConfig: Codable {
    let items: [Item]
    
    struct Item: Codable {
        let imageName: String
        let title: String
    }
}

struct FeedbackConfig: Codable {
    let title: String
    let image: String
    let description: String
    let fields: Fields
    let sendButtonTitle: String
    
    struct Fields: Codable {
        let title: TextFieldConfig
        let feedback: TextFieldConfig
    }
}

struct SupportConfig: Codable {
    let link: String
}

struct TextFieldConfig: Codable, Hashable {
    let title: String
    var placeholder: String = ""
}

struct EmptyConfig: Codable {
    let image: String
    let description: String
    let button: String
}

struct SettingsManager {
    static let shared = SettingsManager.fetchSettings()!
    private init() {}
    
    private static func fetchSettings() -> AppSettings? {
        let settingsFilePath = Bundle.main.path(forResource: "AppSettings", ofType: "json")!
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: settingsFilePath), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let result = try decoder.decode(AppSettings.self, from: data)
            return result
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
