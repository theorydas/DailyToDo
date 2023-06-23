import SwiftUI

struct DayListView: View {
    @ObservedObject var taskDatabase: TaskDatabase = TaskDatabase()
    @ObservedObject var day: Day = Day()
    
    var body: some View {
        VStack {
            DayBannerView(day: day)
            WeekView(taskListDay: day)
            TaskListView(taskDatabase: taskDatabase, day: day)
        }
        .frame(width: 298).frame(minHeight: 300)
        .ignoresSafeArea() //TODO: What if I have other padding instead and not this???
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
