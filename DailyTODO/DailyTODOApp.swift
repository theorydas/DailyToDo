import SwiftUI

@main
struct WindowTestApp: App {
    var body: some Scene {
        WindowGroup {
            HStack{
                DayListView(DaysInFuture: -1)
                DayListView(DaysInFuture: 0)
                DayListView(DaysInFuture: 1)
            }
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
    }
}
