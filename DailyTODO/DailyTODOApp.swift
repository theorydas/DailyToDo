import SwiftUI

@main
struct WindowTestApp: App {
    var body: some Scene {
        WindowGroup {
            DayListView(taskDatabase: readTasks())
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
