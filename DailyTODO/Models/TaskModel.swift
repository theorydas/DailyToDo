import SwiftUI

class TaskModel: ObservableObject {
    @Published var tasks: [Task] = [Task()]
    
    func addTask(_ taskText: String = "") {
        // Before adding the task, check if there are any with empty texts and remove them.
        tasks.removeAll(where: { $0.text.isEmpty })
        
        tasks.append(Task(taskText))
    }

    func removeTask(_ task: Task) {
        guard !task.text.isEmpty else {return}
        
        tasks.removeAll(where: { $0 == task })
    }
}

class Task: Hashable, ObservableObject {
    var id: UUID
    @Published var text: String
    @Published var state: Double
    
    init(_ text: String = "", state: Double = 0) {
        self.id = UUID()
        self.text = text
        self.state = state
    }
    
    func toggleState() {
        guard !text.isEmpty else {return}
        
        if state != 1 {state = 1} // You prefer completing instead of clearing your progress.
        else {state = 0}
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
