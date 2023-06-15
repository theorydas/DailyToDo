import SwiftUI

@main
struct WindowTestApp: App {
    var body: some Scene {
        WindowGroup {
            DayListView(daysInFuture: 0)
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DayListView(daysInFuture: 0)
    }
}
