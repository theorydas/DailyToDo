import SwiftUI

struct DayListView: View {
    @ObservedObject var taskDatabase: TaskDatabase = TaskDatabase()
    @ObservedObject var day: Day = Day()
    
    var body: some View {
        VStack {
            WeekView(taskListDay: day)
            DayBannerView(day: day)
            TaskListView(taskDatabase: taskDatabase, day: day)
        }
        .frame(width: 298).frame(minHeight: 300)
        .ignoresSafeArea()
        .onReceive(NotificationCenter.default.publisher(for: NSApplication.willTerminateNotification), perform: { output in
            saveTasks(taskDatabase)
        })
    }
}

struct TaskListView: View {
    @ObservedObject var taskDatabase: TaskDatabase
    @ObservedObject var day: Day
    @ObservedObject var tasksInDay: TaskModel
    
    init(taskDatabase: TaskDatabase, day: Day) {
        self.taskDatabase = taskDatabase
        self.day = day
        self.tasksInDay = taskDatabase.tasks(day)
    }
    
    var body: some View {
        ScrollView {
            ForEach (tasksInDay.tasks, id: \.self) { taskObject in
                TaskTodoView(task: taskObject, tasksInDay: tasksInDay)
            }
        }
    }
}
