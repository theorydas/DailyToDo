import SwiftUI

@main
struct WindowTestApp: App {
    var body: some Scene {
        WindowGroup {
            DayListView(DaysInFuture: 0)
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
    }
}
