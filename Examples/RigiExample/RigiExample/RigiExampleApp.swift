
import SwiftUI

#if canImport(RigiSDK)
import RigiSDK
#endif

@main
struct RigiExampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    #if canImport(RigiSDK)
                    Rigi.start { setttings in
                        setttings.addLabelBorders = true
                        setttings.labelBorderColor = "#ff0000"
                    }
                    #endif
                }
        }
    }
}
