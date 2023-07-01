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
        let myTaskForTheDay = TaskModel([
            Task("Wake up this morning"),
            Task("Eat breakfast"),
            Task("Spin(or)"),
            Task("Go to the gym :)")
        ])
        
        let test_tasks = TaskDatabase(tasks: myTaskForTheDay)
        
        DayListView(taskDatabase: test_tasks)
    }
}
