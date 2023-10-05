//
//  VoiceViewModel.swift
//  FoodTime
//
//  Created by Sevak Tadevosyan on 28.09.23.
//

import Foundation
import AVFoundation

struct Recording: Equatable {
    let fileURL: URL
    let createdAt: Date
    var duration: Int
    var isPlaying: Bool    
}

class VoiceViewModel : NSObject, ObservableObject , AVAudioPlayerDelegate {
    
    var audioRecorder : AVAudioRecorder!
    var audioPlayer : AVAudioPlayer!
    
    var indexOfPlayer = 0
    
    @Published var isRecording: Bool = false
    
    @Published var recording: Recording!
    
    @Published var countSec = 0
    @Published var timerCount : Timer?
    @Published var timer: Int = 0
    @Published var toggleColor : Bool = false
    
    override init() {
        super.init()
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        recording?.isPlaying = false
    }
    
  
    
    func startRecording() {
        
        let recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Cannot setup the Recording")
        }
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName = path.appendingPathComponent("FoodTest : \(Date().toString(dateFormat: "dd-MM-YY 'at' HH:mm:ss")).m4a")
        
        recording = .init(fileURL: fileName, createdAt: Date(), duration: timer, isPlaying: false)
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        
        do {
            audioRecorder = try AVAudioRecorder(url: fileName, settings: settings)
            audioRecorder.prepareToRecord()
            audioRecorder.record()
            isRecording = true
            
            timerCount = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (value) in
                self.countSec += 1
                self.timer = self.countSec
            })
            
        } catch {
            print("Failed to Setup the Recording")
        }
    }
    
    
    func stopRecording() {
        guard let audioRecorder else { return }
        audioRecorder.stop()
        isRecording = false
        self.countSec = 0
        recording.duration = timer
        timerCount!.invalidate()
        
    }
    
    
    func startPlaying(with url: URL) {
        let playSession = AVAudioSession.sharedInstance()
        
        do {
            try playSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        } catch {
            print("Playing failed in Device")
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.play()
        } catch {
            print("Playing Failed")
        }
        
        
    }
    
    func stopPlaying() {
        if isRecording || (audioPlayer != nil && audioPlayer.isPlaying) {
            audioPlayer.stop()
        }
    }
}

extension VoiceViewModel {
    func covertSecToMinAndHour(seconds: Int) -> String {
        
        let (_,m,s) = (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
        let sec : String = s < 10 ? "0\(s)" : "\(s)"
        return "\(m):\(sec)"
        
    }
}
