import SwiftUI

struct DayListView: View {
    @StateObject var tasksInDay = TaskModel()
    @State var day: Day = Day()
    
    var body: some View {
        VStack {
            DayListBanner(day: day)
            CalendarBubbles()
            List {
                // tasksInDay.tasks have a name which can be repeated, ForEach should be given a unique id despite that.
                ForEach (tasksInDay.tasks, id: \.self) { taskObject in
                    TaskTodoView(task: taskObject, tasksInDay: tasksInDay)
                }
            }
            Spacer()
            Button(action: {
                tasksInDay.addTask(taskText: "New Task (\(tasksInDay.tasks.count))")
            }) {
                Text("Add new task")
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.bottom, -30)
        }
        .frame(width: 298, height: 380)
        .ignoresSafeArea()
    }
}
