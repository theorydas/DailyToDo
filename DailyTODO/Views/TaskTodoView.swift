import SwiftUI

struct TaskTodoView: View {
    @FocusState private var isTextFieldFocused: Bool
    @StateObject var task: Task
    var tasksInDay: TaskModel
    @State var isHovered: Bool = false
    
    var body: some View {
        HStack{
            Image(systemName: task.state == 0 ? "circle" : "largecircle.fill.circle")
                .foregroundColor(.accentColor)
                .opacity(determineOpacity())
                .onTapGesture {task.toggleState()}
            
            if task.state != 1 { // We separete the two views here, because TextField does not support strikethrough.
                TextField("...", text: $task.text)
                    .font(.system(size: 14))
                    .lineLimit(1)
                    .textFieldStyle(.plain)
                    .background(.clear)
                    .focused($isTextFieldFocused)
                    .onAppear(perform: {
                        guard tasksInDay.tasks.count == 0 else { isTextFieldFocused.toggle(); return }
                    })
                    .onSubmit { tasksInDay.addTask() }
            } else {
                Text(task.text)
                    .font(.system(size: 14))
                    .opacity(0.5)
                    .strikethrough()
                    .lineLimit(1)
                    .padding(.leading, 8)
            }
            Spacer()
            ZStack{
                Image(systemName: "trash")
                    .onTapGesture { tasksInDay.removeTask(task) }
                    .opacity(isHovered ? 0.7 : 0)
                    .foregroundColor(.red)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.vertical, 5)
        .overlay{
            Divider().padding(.top, 24).padding(.trailing, 75).padding(.leading, 10)
        }
        .onHover {hovering in isHovered = hovering}
    }

    func determineOpacity() -> Double {
        guard !task.text.isEmpty else { return 0.4 }

        return task.state == 0 ? 1 : 0.8
    }
}
