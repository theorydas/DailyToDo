import SwiftUI

@main
struct WindowTestApp: App {
    var body: some Scene {
        WindowGroup {
            DayListView()
        }
        .windowStyle(.hiddenTitleBar)
        .windowResizability(.contentSize)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DayListView()
    }
}
