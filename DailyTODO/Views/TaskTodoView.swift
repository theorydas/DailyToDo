import SwiftUI

struct TaskTodoView: View {
    @StateObject var task: Task
    var tasksInDay: TaskModel
    
    var body: some View {
        HStack{
            Image(systemName: task.state == 0 ? "circle" : "circle.fill")
                .foregroundColor(.accentColor)
                .opacity(task.state == 0 ? 1 : 0.8)
                .onTapGesture {task.state = task.state == 0.0 ? 1 : 0}
            TextField("...", text: $task.text, onCommit: deleteEmptyTask)
                    .opacity(task.state == 0 ? 1 : 0.5)
                    .strikethrough(task.state == 0 ? false : true)
                    .lineLimit(1)
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 10)
        .swipeActions(allowsFullSwipe: false) {
            Button(role: .destructive) {
                tasksInDay.removeTask(task)
            } label: {
                Label("Delete", systemImage: "trash.fill")
            }
        }
    }
    
    func deleteEmptyTask() {
        if task.text == "" {
            tasksInDay.removeTask(task)
        }
    }
}
