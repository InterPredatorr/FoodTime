//
//  ChatHelper.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 27.09.23.
//

import SwiftUI
import Combine

class ChatHelper: ObservableObject {
    var didChange = PassthroughSubject<Void, Never>()
    @Published var realTimeMessages = DataSource.messages
    
    func sendMessage(_ chatMessage: Message) {
        withAnimation {
            realTimeMessages.append(chatMessage)
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                withAnimation {
                    self?.realTimeMessages.append(Message(content: "Hello Dear", user: DataSource.firstUser))
                    DataSource.firstUser.isTyping.toggle()
                    self?.didChange.send(())
                }
            }
            didChange.send(())
        }
    }
}
