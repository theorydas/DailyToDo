import SwiftUI

struct DayListView: View {
    @StateObject var tasksInDay = TaskModel()
    @State var day: Day = Day()
    
    var body: some View {
        VStack {
            DayBannerView(day: day)
            CalendarBubbles()
            TaskListView(tasksInDay: tasksInDay)
        }
        .frame(width: 298).frame(minHeight: 300)
        .ignoresSafeArea() //TODO: What if I have other padding instead and not this???
    }
}

struct TaskListView: View {
    @StateObject var tasksInDay: TaskModel
    
    var body: some View {
        List {
            // tasksInDay.tasks have a name which can be repeated, ForEach should be given a unique id despite that.
            ForEach (tasksInDay.tasks, id: \.self) { taskObject in
                TaskTodoView(task: taskObject, tasksInDay: tasksInDay)
            }
        }
    }
}
