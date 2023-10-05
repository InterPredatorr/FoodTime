//
//  ChatView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 27.09.23.
//

import SwiftUI
import PhotosUI

struct ChatView: View {
    
    let buttonLenght = 30.0
    @State var sendingMessage = Message(content: "", image: nil, user: DataSource.secondUser)
    @EnvironmentObject var chatHelper: ChatHelper
    @ObservedObject private var keyboard = KeyboardResponder()
    @ObservedObject var voiceVM = VoiceViewModel()
    @State var indexPathToSetVisible: IndexPath?
    @State private var presentSheet = false
    
    var body: some View {
        VStack {
            ContentHeaderView(title: DataSource.firstUser.name.uppercased())
            ScrollView {
                VStack {
                    messages
                    pendingView
                    Spacer()
                        .frame(maxWidth: .infinity)
                }
                .padding(.horizontal)
            }
            .background(Color.background)
            selectedImage
            HStack(alignment: .center, spacing: 10) {
                if !voiceVM.isRecording {
                    textField
                } else {
                    Spacer()
                    LoadingView()
                    LoadingView()
                    LoadingView()
                }
                VoiceMessageView(voiceVM: voiceVM) { recording in
                    sendingMessage.recording = recording
                    sendMessage()
                }
                photoPickerButton
                sendButton
            }
            .frame(height: 50)
            .padding()
        }
        .padding(.bottom, keyboard.currentHeight)
        .edgesIgnoringSafeArea(keyboard.currentHeight == 0.0 ? .leading : .bottom)
        .rootViewSetup()
        .sheet(isPresented: $presentSheet) {
            ImagePicker(selectedImage: $sendingMessage.image, sourceType: .photoLibrary)
                .edgesIgnoringSafeArea(.all)
                
        }
    }
    
    
}


extension ChatView {
    
    var messages: some View {
        ForEach($chatHelper.realTimeMessages) { msg in
            MessageView(currentMessage: msg)
        }
    }
    
    var photoPickerButton: some View {
        Button {
            presentSheet.toggle()
        } label: {
            photoPickerImage
        }
    }
    
    var photoPickerImage: some View {
        Image(systemName: Images.attachImage)
            .resizable()
            .foregroundColor(.mainColor)
            .frame(width: buttonLenght,
                   height: buttonLenght)
            .cornerRadius(10)
    }
    
    var selectedImage: some View {
        Group {
            if sendingMessage.image != nil {
                HStack {
                    Image(uiImage: sendingMessage.image!)
                        .resizable()
                        .frame(width: 50, height: 50)
                    Spacer()
                }
                .padding()
            }
        }
    }
    
    var pendingView: some View {
        Group {
            if DataSource.firstUser.isTyping {
                HStack {
                    MessageProfileImageView(image: "supportSpecialist")
                    LoadingView()
                    Spacer()
                }
            }
        }
    }
    
    var sendButton: some View {
        Button {
            withAnimation {
                sendMessage()
                
            }
        } label: {
            Image(systemName: Images.send)
                .resizable()
                .foregroundColor(isAbleToSend ? .mainColor : .mainGrayDark)
                .frame(width: buttonLenght,
                       height: buttonLenght)
        }
        .fixedSize(v: false)
        .disabled(!isAbleToSend)
    }
    
    var textField: some View {
        TextFieldView(text: $sendingMessage.content,
                      config: .init(title: "", placeholder: LocalizedStrings.messagePlaceholder),
                      cornerRadius: 50,
                      background: .mainWhite,
                      height: 50)
    }
    
    func sendMessage() {
        chatHelper.sendMessage(sendingMessage)
        UIApplication.shared.endEditing()
        DataSource.firstUser.isTyping.toggle()
        sendingMessage.content = ""
        sendingMessage.image = nil
        sendingMessage.recording = nil
        sendingMessage.id = UUID()
    }
    
    private var isAbleToSend: Bool {
        !sendingMessage.content.isEmpty || sendingMessage.image != nil
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
