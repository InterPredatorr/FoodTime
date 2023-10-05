//
//  VoiceMessageView.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 28.09.23.
//

import SwiftUI
import AVFoundation

struct VoiceMessageView: View {
    
    @ObservedObject var voiceVM: VoiceViewModel
    @State var isRecording: Bool = false
    let onEnd: (Recording) -> Void
    
    var body: some View {
        HStack {
            if voiceVM.isRecording {
                Text(voiceVM.covertSecToMinAndHour(seconds: voiceVM.timer))
            }
            RecordButton(isRecording: $isRecording.onUpdate(handleRecording))
        }
    }
    
    func handleRecording() {
        if isRecording {
            voiceVM.startRecording()
        } else {
            voiceVM.stopRecording()
            onEnd(voiceVM.recording)
        }
    }
}

private struct RecordButton: View {
    
    @Binding var isRecording: Bool
    
    var body: some View {
        Button {
            isRecording.toggle()
        } label: {
            Image(systemName: Images.microphone)
                .resizable()
                .frame(width: 20, height: 30)
                .foregroundColor(isRecording ? .mainGreen : .mainColor)
        }
    }
}
