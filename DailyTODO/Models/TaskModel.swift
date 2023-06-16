import SwiftUI

class TaskModel: ObservableObject {
    @Published var tasks: [Task] = []
    
    func addTask(taskText: String) {
        tasks.append(Task(text: taskText))
    }

    func removeTask(_ task: Task) {
        tasks.removeAll(where: { $0 == task })
    }
}

class Task: Hashable {
    var id: UUID
    @State var text: String
    var state: Double
    
    init(text: String, state: Double = 0) {
        self.id = UUID()
        self.text = text
        self.state = state
    }
}


extension Task {
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
