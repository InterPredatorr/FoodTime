//
//  Models.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 27.09.23.
//

import SwiftUI

struct Message: Identifiable {
    var id = UUID()
    var content: String
    var image: UIImage? 
    var recording: Recording?
    var user: User
}

struct User: Hashable {
    var name: String
    var avatar: String
    var isCurrentUser: Bool = false
    var isTyping: Bool = false
}

struct DataSource {
    static var firstUser = User(name: "Support Specialist", avatar: "supportSpecialist")
    static var secondUser = User(name: "Duy Bui", avatar: Images.login, isCurrentUser: true)
    static let messages: [Message] = []
}
