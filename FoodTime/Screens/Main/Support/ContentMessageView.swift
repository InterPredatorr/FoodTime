//
//  ContentMessageView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 27.09.23.
//

import SwiftUI

struct ContentMessageView: View {
    
    @EnvironmentObject var chatHelper: ChatHelper
    var voiceVM = VoiceViewModel()
    @Binding var message: Message
    @State var timer: Timer?
    @State var timerCount: Int = 0
    
    var body: some View {
        VStack(alignment: .trailing) {
            sendingVoice
            sendingMessage
            sendingImage
        }
        .onAppear {
            if message.recording != nil {
                timerCount = message.recording!.duration
            }
        }
    }
}

extension ContentMessageView {
    
    var buttonLabel: some View {
        Image(systemName: message.recording!.isPlaying ? Images.pause : Images.play)
            .resizable()
            .frame(width: 20, height: 25)
    }
    
    var sendingMessage: some View {
        Group {
            if !message.content.isEmpty {
                Text(message.content)
                    .padding(10)
                    .foregroundColor(message.user.isCurrentUser ? .white : .mainWhite)
                    .background(message.user.isCurrentUser ? Color.mainColor : Color.mainGrayDark)
                    .cornerRadius(10, corners: [.topLeft,
                                                .topRight,
                                                (message.user.isCurrentUser ? .bottomLeft : .bottomRight)])
            }
        }
    }
    
    var sendingVoice: some View {
        Group {
            if message.recording != nil {
                RoundedView {
                    HStack {
                        Text(voiceVM.covertSecToMinAndHour(seconds: timerCount))
                        Button {
                            handleButtonTap()
                        } label: {
                            buttonLabel
                        }
                    }
                    .foregroundColor(.white)
                    .padding(5)
                }
            }
        }
    }
    
    var sendingImage: some View {
        Group {
            if message.image != nil {
                Image(uiImage: message.image!)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
            }
        }
    }
    
    func handleButtonTap() {
        message.recording!.isPlaying.toggle()
        stopOtherRecordings()
        voiceVM.startPlaying(with: message.recording!.fileURL)
        if message.recording!.isPlaying {
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (value) in
                timerCount -= 1
                if timerCount == 0 {
                    timer?.invalidate()
                    message.recording!.isPlaying.toggle()
                    timerCount = message.recording!.duration
                }
            })
        } else {
            timer?.invalidate()
            voiceVM.stopPlaying()
        }
    }
    
    func stopOtherRecordings() {
        chatHelper.realTimeMessages.indices.forEach { index in
            if chatHelper.realTimeMessages[index].id != message.id {
                chatHelper.realTimeMessages[index].recording?.isPlaying = false
            }
        }
        voiceVM.stopPlaying()
    }
}

struct ContentMessageView_Previews: PreviewProvider {
    
    static var previews: some View {
        @State var message = Message(content: "", user: DataSource.firstUser)
        ContentMessageView(message: $message)
    }
}
