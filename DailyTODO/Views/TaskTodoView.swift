import SwiftUI

struct TaskTodoView: View {
    @FocusState private var isTextFieldFocused: Bool
    @StateObject var task: Task
    var tasksInDay: TaskModel
    
    var body: some View {
        HStack{
            Image(systemName: task.state == 0 ? "circle" : "circle.fill")
                .foregroundColor(.accentColor)
                .opacity(determineOpacity())
                .onTapGesture {task.toggleState()}
            if task.state != 1 { // We separete the two views here, because TextField does not support strikethrough.
                TextField("...", text: $task.text, onCommit: {tasksInDay.addTask()} )
                    .lineLimit(1)
                    .focused($isTextFieldFocused)
                    .onAppear(perform: {
                        guard tasksInDay.tasks.count == 0 else { isTextFieldFocused.toggle(); return }
                    })
                    .onHover { hovering in if hovering { NSCursor.iBeam.set() } else { NSCursor.arrow.set() }
                    }
            } else {
                Text(task.text)
                    .opacity(0.5)
                    .strikethrough()
                    .lineLimit(1)
                    .padding(.leading, 8)
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.leading, 10)
        .swipeActions(allowsFullSwipe: true) {
            Button(role: .destructive) {
                tasksInDay.removeTask(task)
            } label: {
                Label("Delete", systemImage: "trash.fill")
            }
        }
    }

    func determineOpacity() -> Double {
        guard !task.text.isEmpty else { return 0.4 }

        return task.state == 0 ? 1 : 0.8
    }
}
