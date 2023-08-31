//
//  VoiceBoard.swift
//  Memory+
//
//  Created by UltraTempest on 2023/8/29.
//

//import SwiftUI
//import Speech
//import AVFoundation
//
//let audioEngine = AVAudioEngine()
//let speechRecognizer = SFSpeechRecognizer()
//let request = SFSpeechAudioBufferRecognitionRequest()
//
//struct VoiceBoard: View {
//    @State private var recognizedText: String = "点击麦克风，说出你的回忆吧！"
//    
//    @State private var audioRecorder: AVAudioRecorder!
//    @State private var isRecording: Bool = false
//    
//    @State private var timer: Timer?
//    @State private var timeRemaining: Int = 20
//    
////    @Binding var audioURLs: [URL]
////    @Binding var audioTexts: [String]
//    
//    @Binding var showVoiceBoard: Bool
//    
//    let maxRecordings: Int = 5
//    @Binding var currentRecording: Int
//    
//    var body: some View {
//        VStack {
//            Spacer()
//            ZStack {
//                Rectangle()
//                  .foregroundColor(.clear)
//                  .frame(height: UIScreen.main.bounds.height * 0.278)
//                  .background(.white)
//                  .cornerRadius(14)
//                  .shadow(color: .black.opacity(0.09), radius: 2, x: 0, y: 0)
//                VStack {
//                    Text(recognizedText)
//                        .font(
//                            Font.custom("PingFang SC", size: 18)
//                                .weight(.medium)
//                        )
//                        .foregroundColor(.black)
//                        .padding(.bottom)
//                        .frame(width: UIScreen.main.bounds.width * 0.677)
//                        .lineLimit(2)
//                    HStack {
//                        Button {
//                            cancelRecording()
//                        } label: {
//                            Image("cancel")
//                        }
//                        .frame(maxWidth: .infinity)
//                        if isRecording {
//                            ZStack {
//                                Image("countdown")
//                                Text("\(timeRemaining)s")
//                                    .font(
//                                        Font.custom("PingFang SC", size: 20)
//                                            .weight(.medium)
//                                    )
//                                    .foregroundColor(.white)
//                            }
//                            .frame(maxWidth: .infinity)
//                        } else {
//                            Button {
//                                startRecording()
//                            } label: {
//                                Image("start")
//                            }
//                        }
//                        Button {
//                            stopRecording()
//                        } label: {
//                            Image("finish")
//                        }
//                        .frame(maxWidth: .infinity)
//                    }
//                }
//            }
//        }
//    }
//    
//    func startRecording() {
//        if currentRecording < maxRecordings {
//            let request = SFSpeechAudioBufferRecognitionRequest()
//            request.shouldReportPartialResults = true
//
//            speechRecognizer?.recognitionTask(with: request) { result, error in
//                guard let result = result else { return }
//                recognizedText = result.bestTranscription.formattedString
//            }
//            
//            if currentRecording == 0 {
//                let now = Date()
//                let formatter = DateFormatter()
//                formatter.dateFormat = "yyyyMMddHHmmss"
//                let timestamp = formatter.string(from: now)
//                let audioFilename = getDocumentsDirectory().appendingPathComponent("DEPRECATEDrecording\(timestamp).m4a")
//                let settings = [
//                    AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
//                    AVSampleRateKey: 44100,
//                    AVNumberOfChannelsKey: 1,
//                    AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
//                ]
//                audioRecorder = try! AVAudioRecorder(url: audioFilename, settings: settings)
//                audioRecorder.record()
//                audioRecorder.stop()
//            }
//            
//            let now = Date()
//            let formatter = DateFormatter()
//            formatter.dateFormat = "yyyyMMddHHmmss"
//            let timestamp = formatter.string(from: now)
//
//            let audioFilename = getDocumentsDirectory().appendingPathComponent("recording\(timestamp).m4a")
//            let settings = [
//                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
//                AVSampleRateKey: 44100,
//                AVNumberOfChannelsKey: 1,
//                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
//            ]
//            audioRecorder = try! AVAudioRecorder(url: audioFilename, settings: settings)
//            audioRecorder.record()
//
//            isRecording = true
//
//            currentRecording += 1
//            audioURLs.append(audioFilename)
//
//            timeRemaining = 20
//            timer?.invalidate()
//            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
//                if self.timeRemaining > 0 {
//                    self.timeRemaining -= 1
//                } else {
//                    self.stopRecording()
//                }
//            }
//            
//            let inputNode = audioEngine.inputNode
//            inputNode.removeTap(onBus: 0)
//            let recordingFormat = inputNode.outputFormat(forBus: 0)
//            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
//                request.append(buffer)
//            }
//            try! audioEngine.start()
//        }/* else {
//            showVoiceCountAlert = true
//        }*/
//    }
//
//    func stopRecording() {
//        audioRecorder.stop()
//        showVoiceBoard = false
//        isRecording = false
//        timer?.invalidate()
//        
//        audioEngine.stop()
//        request.endAudio()
//        
//        audioTexts.append(recognizedText)
//        recognizedText = "点击麦克风，说出你的回忆吧！"
//    }
//    
//    func cancelRecording() {
//        audioRecorder.stop()
//        showVoiceBoard = false
//        isRecording = false
//        timer?.invalidate()
//        
//        audioEngine.stop()
//        request.endAudio()
//        
//        recognizedText = "点击麦克风，说出你的回忆吧！"
//        audioURLs.removeLast()
//        currentRecording -= 1
//    }
//
//    func getDocumentsDirectory() -> URL {
//        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        return paths[0]
//    }
//}
//
//struct VoiceBoard_Previews: PreviewProvider {
//    static var previews: some View {
//        VoiceBoard(/*audioURLs: .constant([]), audioTexts: .constant([]), */showVoiceBoard: .constant(true), currentRecording: .constant(0))
//    }
//}
