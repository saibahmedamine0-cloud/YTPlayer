import SwiftUI
import AVFoundation

@main
struct YTPlayerApp: App {
    init() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set audio session")
        }
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
