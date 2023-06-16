import SwiftUI

struct TaskTodoView: View {
    var task: Task
    var tasksInDay: TaskModel

    @State private var isHovered: Bool = false
    @State private var inEditMode: Bool = false
    @State private var tempTaskText: String = "" // tempTaskText is used to temporarily write task text before updating to taskmodel.
    
    
    var body: some View {
        ZStack {
            HStack{
                Image(systemName: task.state == 0 ? "circle" : "circle.fill")
                    .foregroundColor(.accentColor)
                    .opacity(task.state == 0 ? 1 : 0.8)
                    .onTapGesture {task.state = task.state == 0 ? 1 : 0}
                if inEditMode {
                    TextField("...", text: $tempTaskText, onCommit: {inEditMode = false; task.text = tempTaskText})
                        .opacity(task.state == 0 ? 1 : 0.5)
                        .strikethrough(task.state == 0 ? false : true)
                        .lineLimit(1)
                } else {
                    Text(task.text)
                        .opacity(task.state == 0 ? 1 : 0.5)
                        .strikethrough(task.state == 0 ? false : true)
                        .lineLimit(1)
                }
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
        .onHover(perform: {_hovered in isHovered = _hovered})
        .onTapGesture(count: 2) {inEditMode = true}
        .onAppear {tempTaskText = task.text}
    }
}
