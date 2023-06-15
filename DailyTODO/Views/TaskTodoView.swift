import SwiftUI

struct TaskTodoView: View {
    var task: Task
    
    @StateObject var tasksInDay: TaskModel
    
    @State private var isHovered: Bool = false
    @State private var inEditMode: Bool = false
    
    var body: some View {
        ZStack {
            HStack{
                Image(systemName: task.state == 0 ? "circle" : "circle.fill")
                    .foregroundColor(.accentColor)
                    .opacity(task.state == 0 ? 1 : 0.8)
                    .onTapGesture {task.state = task.state == 0 ? 1 : 0}
                if inEditMode {
                    TextField("...", text: task.$text, onCommit: {inEditMode = false})
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
                Image(systemName: "trash")
                    .padding(.trailing, 5)
                    .opacity(isHovered ? 1 : 0)
                    .onTapGesture {tasksInDay.removeTask(task)}
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 10)
        }
        .onHover(perform: {_hovered in isHovered = _hovered})
        .onTapGesture(count: 2) {inEditMode = true}
    }
}

//struct TaskTodoView_Previews: PreviewProvider {
//    @StateObject var tasksInDay = TaskModel()
//
//    static var previews: some View {
//        TaskTodo(elementText: "Generetic Task", tasksInDay: tasksInDay)
//    }
//}
