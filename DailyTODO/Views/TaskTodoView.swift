import SwiftUI
import AudioToolbox

struct TaskTodoView: View {
    @FocusState private var isTextFieldFocused: Bool
    @StateObject var task: Task
    var tasksInDay: TaskModel
    @State var opacity: Double = 1
    @State var offset: CGFloat = 0
    @State var isHovered: Bool = false
    
    var body: some View {
        HStack{
            Image(systemName: task.state == 0 ? "circle" : "largecircle.fill.circle")
                .foregroundColor(.accentColor)
                .opacity(determineOpacity())
                .onTapGesture {
                    task.toggleState()
                    // If this was the last task and it was completed, we add a new task.
                    if task.state == 1 && tasksInDay.tasks.last?.id == task.id {
                        tasksInDay.addTask()
                    }
                }
            
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
            // If the task is not empty, we show the trash icon.
            if !task.text.isEmpty && isHovered {
                Image(systemName: "trash")
                    .onTapGesture {
                        AudioServicesPlaySystemSound(0xf)
                        
                        // Animate the task to move to the left and fade out.
                        withAnimation(.easeInOut(duration: 0.2)) {
                            offset = -100
                            opacity = 0
                            tasksInDay.removeTask(task)
                        }
                    }
                    .opacity(0.7)
                    .foregroundColor(.red)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.vertical, 5)
        .overlay{
            Divider().padding(.top, 24).padding(.trailing, 75).padding(.leading, 10)
        }
        .opacity(opacity)
        .offset(x: offset)
        .onHover { state in
            isHovered = state
        }
    }

    func determineOpacity() -> Double {
        guard !task.text.isEmpty else { return 0.4 }

        return task.state == 0 ? 1 : 0.8
    }
}
