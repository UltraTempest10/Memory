//
//  CreateView.swift
//  Memory+
//
//  Created by UltraTempest on 2023/8/21.
//

import SwiftUI
import UIKit
import Speech
import AVFoundation
import Parse

let audioEngine = AVAudioEngine()
let speechRecognizer = SFSpeechRecognizer()
let request = SFSpeechAudioBufferRecognitionRequest()
var voicePlayer: AVPlayer?

struct CreateView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showDismissAlert: Bool = false
    
    @State private var content: String = ""
    @State private var title: String = ""
    
    @State private var didTakePhoto: Bool = false
    @State private var showCameraPicker: Bool = false
    @State private var image: UIImage = UIImage()
    
    @State private var selectedMusicIndex: Int? = nil
    
    @State private var showVoiceBoard: Bool = false
    @State private var isRecording: Bool = false
    @State private var showVoiceCountAlert: Bool = false
    @State private var showVoiceDeleteAlert: Bool = false
    @State private var audioRecorder: AVAudioRecorder!
    @State private var audioURLs: [URL] = []
    @State private var audioTexts: [String] = []
    @State private var recognizedText: String = ""
    @State private var timer: Timer?
    @State private var timeRemaining: Int = 20
    @State private var maxRecordings: Int = 5
    @State private var currentRecording: Int = 0
    
    @State private var uploadStatus: Int = -1
    
    var body: some View {
        ZStack {
            VStack {
                Image("Rectangle 2975")
                    .resizable()
                    .scaledToFill()
                    .frame(height: UIScreen.main.bounds.height * 0.159)
                Spacer()
            }
            .ignoresSafeArea(.keyboard, edges: .bottom)
            
            VStack {
                TextField("输入你的标题", text: $title)
                    .padding(.top, 48.0)
                    .padding([.leading, .bottom, .trailing])
                    .font(Font
                        .custom("PingFang SC", size: 25)
                        .weight(.medium)
                    )
                    .multilineTextAlignment(.center)
                    ScrollView {
                        TextField("在此输入你的回忆", text: $content, axis: .vertical)
                            .padding(.horizontal)
                            .font(
                                Font.custom("PingFang SC", size: 18)
                                    .weight(.medium)
                            )
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(height: 0.5)
                            .background(Constants.lightGray)
                        ZStack {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width)
                                .cornerRadius(6)
                            VStack {
                                if !audioTexts.isEmpty {
                                    LazyVStack(spacing: 10) {
                                        ForEach(audioTexts.indices, id: \.self) { index in
                                            let text = audioTexts[index]
                                            HStack {
                                                VoiceRow(text: text)
                                                    .onTapGesture {
                                                        let url = audioURLs[index]
                                                        let playerItem = AVPlayerItem(url: url)
                                                        voicePlayer = AVPlayer(playerItem: playerItem)
                                                        voicePlayer?.play()
                                                    }
                                                    .onLongPressGesture {
                                                        showVoiceDeleteAlert = true
                                                    }
                                                    .alert(isPresented: $showVoiceDeleteAlert) {
                                                        Alert(
                                                            title: Text("删除碎碎念语音记录"),
                                                            message: Text("即将删除“" + text + "”，是否继续删除？"),
                                                            primaryButton: .destructive(Text("删除"), action: {
                                                                audioTexts.remove(at: index)
                                                                audioURLs.remove(at: index)
                                                                currentRecording -= 1
                                                            }),
                                                            secondaryButton: .cancel(Text("取消"))
                                                        )
                                                    }
                                                Spacer()
                                            }
                                        }
                                    }
                                }
                                Spacer()
                            }
                            .padding(.all)
                        }
                        .frame(height: UIScreen.main.bounds.height * 0.305)
                        if selectedMusicIndex != nil {
                            MusicPreviewRow(index: selectedMusicIndex!)
                        }
                    }
                    .scrollDismissesKeyboard(.interactively)
                    Spacer()
            }
            .padding(.bottom, 16.0)
            .background(Constants.bgColor)
            .frame(height: UIScreen.main.bounds.height * 0.751)
            .clipShape(RoundedCorner(radius: 10, corners: [.topLeft, .topRight]))
            ZStack {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button {
                            showCameraPicker = true
                        } label: {
                            Image("photograph")
                        }
                    }
                    .padding(.horizontal)
                    HStack {
                        Spacer()
                        NavigationLink {
                            MusicView(mode: 0, image: image, title: title, selectedIndex: $selectedMusicIndex)
                        } label: {
                            Image("music")
                        }
                    }
                    .padding(.horizontal)
                    if didTakePhoto {
                        VStack {
                            Button {
                                showVoiceBoard = true
                            } label: {
                                if currentRecording == 0 {
                                    BigButton(text: "碎碎念语音记录")
                                } else {
                                    BigButton(text: "继续添加")
                                }
                            }
                            .alert(isPresented: $showVoiceCountAlert) {
                                Alert(title: Text("已经达到数量上限"), message: Text("碎碎念语音记录的最大数量为5条。"), dismissButton: .default(Text("OK")))
                            }
                        }
                    }
                }
                .padding(.bottom, 48.0)
                if showVoiceBoard {
                    VStack {
                        Spacer()
                        ZStack {
                            Rectangle()
                              .foregroundColor(.clear)
                              .frame(height: UIScreen.main.bounds.height * 0.278)
                              .background(.white)
                              .cornerRadius(14)
                              .shadow(color: .black.opacity(0.09), radius: 2 , x: 0, y: 0)
                            if uploadStatus == 2 {
                                VStack {
                                    Image("uploading")
                                    BigButton(text: "正在上传中……")
                                }
                            } else {
                                VStack {
                                    Text(recognizedText)
                                        .font(
                                            Font.custom("PingFang SC", size: 18)
                                                .weight(.medium)
                                        )
                                        .foregroundColor(.black)
                                        .padding(.bottom)
                                        .frame(width: UIScreen.main.bounds.width * 0.677)
                                        .lineLimit(2)
                                    HStack {
                                        Button {
                                            cancelRecording()
                                        } label: {
                                            Image("cancel")
                                        }
                                        .frame(maxWidth: .infinity)
                                        if isRecording {
                                            ZStack {
                                                Image("countdown")
                                                Text("\(timeRemaining)s")
                                                    .font(
                                                        Font.custom("PingFang SC", size: 20)
                                                            .weight(.medium)
                                                    )
                                                    .foregroundColor(.white)
                                            }
                                            .frame(maxWidth: .infinity)
                                        } else {
                                            Button {
                                                startRecording()
                                            } label: {
                                                Image("start")
                                            }
                                        }
                                        Button {
                                            stopRecording()
                                        } label: {
                                            Image("finish")
                                        }
                                        .frame(maxWidth: .infinity)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
//        .frame(width: 375, height: 812)
        .background(Constants.bgColor)
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    showDismissAlert = true
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.white)
                        .frame(width: 10, height: 20)
                }
                .alert(isPresented: $showDismissAlert) {
                    Alert(
                        title: Text("即将退出编辑页面"),
                        message: Text("退出后，已经编辑的内容将被删除，是否继续？"),
                        primaryButton: .destructive(Text("退出"), action: {
                            presentationMode.wrappedValue.dismiss()
                        }),
                        secondaryButton: .cancel(Text("取消"))
                    )
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    if uploadStatus != 2 {
                        showVoiceBoard = true
                        uploadPost()
                    }
                } label: {
                    Text("完成")
                        .font(
                            Font.custom("PingFang SC", size: 20)
                                .weight(.medium)
                        )
                        .foregroundColor(.white)
                }
            }
        }
        .sheet(isPresented: $showCameraPicker,
               content: {
            ImagePicker(sourceType: .camera) { image in
                self.image = image
            }
        })
        .onChange(of: image) { newValue in
            didTakePhoto = true
        }
    }
    
    func startRecording() {
        if currentRecording < maxRecordings {
            let request = SFSpeechAudioBufferRecognitionRequest()
            request.shouldReportPartialResults = true

            speechRecognizer?.recognitionTask(with: request) { result, error in
                guard let result = result else { return }
                recognizedText = result.bestTranscription.formattedString
            }
            
            if currentRecording == 0 {
                let now = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyyMMddHHmmss"
                let timestamp = formatter.string(from: now)
                let audioFilename = getDocumentsDirectory().appendingPathComponent("DEPRECATEDrecording\(timestamp).m4a")
                let settings = [
                    AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                    AVSampleRateKey: 44100,
                    AVNumberOfChannelsKey: 1,
                    AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
                ]
                audioRecorder = try! AVAudioRecorder(url: audioFilename, settings: settings)
                audioRecorder.record()
                audioRecorder.stop()
            }
            
            let now = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMddHHmmss"
            let timestamp = formatter.string(from: now)

            let audioFilename = getDocumentsDirectory().appendingPathComponent("recording\(timestamp).m4a")
            let settings = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            audioRecorder = try! AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.record()

            isRecording = true

            currentRecording += 1
            audioURLs.append(audioFilename)

            timeRemaining = 20
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    self.stopRecording()
                }
            }
            
            let inputNode = audioEngine.inputNode
            inputNode.removeTap(onBus: 0)
            let recordingFormat = inputNode.outputFormat(forBus: 0)
            inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { buffer, _ in
                request.append(buffer)
            }
            try! audioEngine.start()
        } else {
            showVoiceCountAlert = true
        }
    }

    func stopRecording() {
        audioRecorder.stop()
        showVoiceBoard = false
        isRecording = false
        timer?.invalidate()
        
        audioEngine.stop()
        request.endAudio()
        
        audioTexts.append(recognizedText)
        recognizedText = ""
    }
    
    func cancelRecording() {
        audioRecorder.stop()
        showVoiceBoard = false
        isRecording = false
        timer?.invalidate()
        
        audioEngine.stop()
        request.endAudio()
        
        recognizedText = ""
        audioURLs.removeLast()
        currentRecording -= 1
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func uploadPost() {
        uploadStatus = 2
        
        let parseObject = PFObject(className:"Post")

        parseObject["creator"] = profile.username
        parseObject["title"] = title
        parseObject["content"] = content
        
        let imageData = image.pngData()
        if imageData != nil {
            let imageFile = PFFileObject(name:"image.png", data:imageData!)
            parseObject["picture"] = imageFile
        }
        
        if let index = selectedMusicIndex {
            if index >= 0 {
                parseObject["music_id"] = musicArray[index].id
            }
        }
        
        parseObject["voice_text"] = audioTexts
        
        let files = audioURLs.enumerated().map { index, url -> PFFileObject in
            let data = try! Data(contentsOf: url)
            let name = "voice\(index).m4a"
            return PFFileObject(name: name, data: data)!
        }
        parseObject["voice_file"] = files

        // Saves the new object.
        parseObject.saveInBackground {
          (success: Bool, error: Error?) in
          if (success) {
            // The object has been saved.
              print("Post uploaded successfully.")
              uploadStatus = 0
              loadMemoryData()
              if let index = selectedMusicIndex {
                  if index >= 0 {
                      musicArray[selectedMusicIndex ?? 0].isSelected = false
                  }
              }
              presentationMode.wrappedValue.dismiss()
          } else {
            // There was a problem, check error.description
              print(error?.localizedDescription.description as Any)
              uploadStatus = 1
          }
        }
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
