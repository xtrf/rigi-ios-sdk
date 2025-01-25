
import SwiftUI
import RigiSDK

@main
struct RigiExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    Rigi.start()
                }
        }
    }
}
