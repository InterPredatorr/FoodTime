//
//  MessageView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 27.09.23.
//

import SwiftUI

struct MessageView: View {
    
    @Binding var currentMessage: Message

    var body: some View {
        HStack(alignment: .bottom, spacing: 15) {
            if !currentMessage.user.isCurrentUser {
                MessageProfileImageView(image: currentMessage.user.avatar)
            } else {
                Spacer()
            }
            ContentMessageView(message: $currentMessage)
            if !currentMessage.user.isCurrentUser {
                Spacer()
            }
        }
    }
}

struct MessageProfileImageView: View {
    
    let image: String
    private let imageSize = 40.0

    var body: some View {
        Image(image)
        .resizable()
        .frame(width: imageSize, height: imageSize, alignment: .center)
        .cornerRadius(imageSize / 2)
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        @State var message = Message(content: "", user: DataSource.firstUser)
        
        MessageView(currentMessage: $message)
    }
}
