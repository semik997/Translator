//
//  MicrophoneManager.swift
//  Translator
//
//  Created by Sem Koliesnikov on 08/02/2025.
//

import AVFoundation

protocol MicrophoneManagerDelegate: AnyObject {
    func didStartRecording()
    func didStopRecording()
    func showSettingAlert()
}

class MicrophoneManager {
    
    weak var delegate: MicrophoneManagerDelegate?
    private var audioRecorder: AVAudioRecorder?
    private var isRecording = false
    
    // Request microphone access
    private func requestMicrophonePermission() {
        AVAudioApplication.requestRecordPermission { [weak self] granted in
            DispatchQueue.main.async {
                if granted {
                    self?.startRecording()
                } else {
                    self?.delegate?.showSettingAlert()
                }
            }
        }
    }
    
    // Start recording
    private func startRecording() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
            try audioSession.setActive(true)
            
            let settings: [String: Any] = [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 12000,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            let filePath = FileManager.default.temporaryDirectory.appendingPathComponent("recording.m4a")
            audioRecorder = try AVAudioRecorder(url: filePath, settings: settings)
            audioRecorder?.record()
            
            isRecording = true
            delegate?.didStartRecording()
            print("Recording started")
        } catch {
            print("Error starting recording: \(error.localizedDescription)")
        }
    }
    
    // Check microphone access
    func checkMicrophonePermission() {
        switch AVAudioApplication.shared.recordPermission {
        case .undetermined:
            requestMicrophonePermission()
        case .denied:
            delegate?.showSettingAlert()
        case .granted:
            startRecording()
        @unknown default:
            fatalError("Unhandled microphone permission state")
        }
    }
    
    // Stop recording
    func stopRecording() {
        audioRecorder?.stop()
        isRecording = false
        delegate?.didStopRecording()
    }
    
    // Get recording status
    func isCurrentlyRecording() -> Bool {
        return isRecording
    }
    
    // Checking the status of the recording
    func toggleRecording() {
        if isCurrentlyRecording() {
            stopRecording()
        } else {
            checkMicrophonePermission()
        }
    }
    
}
