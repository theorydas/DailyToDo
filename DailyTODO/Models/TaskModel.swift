import SwiftUI

class TaskDatabase: ObservableObject, Codable {
    @Published var lists: [String : TaskModel]
    
    init(tasks: TaskModel = TaskModel()) {
        self.lists = [Day().fullName: tasks]
    }
    
    func tasks(_ dayToSearch: Day) -> TaskModel {
        if lists[dayToSearch.fullName] == nil {
            lists[dayToSearch.fullName] = TaskModel()
        }
        
        return lists[dayToSearch.fullName]!
    }
    
     private enum CodingKeys : String, CodingKey {
         case lists
     }
    
     func encode(to encoder: Encoder) throws {
         var container = encoder.container(keyedBy: CodingKeys.self)
         try container.encode(lists, forKey: .lists)
     }
    
     required init(from decoder:Decoder) throws {
         let values = try decoder.container(keyedBy: CodingKeys.self)
         
         lists = try values.decode([String : TaskModel].self, forKey: .lists)
     }
}

class TaskModel: ObservableObject, Codable {
    @Published var tasks: [Task]
    
    init(_ tasks: [Task] = [Task()]) {
        self.tasks = tasks
        
        // If there are no empty tasks, add one.
        if !tasks.contains(where: { $0.text.isEmpty }) {
            addTask()
        }
    }
    
    func addTask(_ taskText: String = "") {
        // Before adding the task, check if there are any with empty texts and remove them.
        tasks.removeAll(where: { $0.text.isEmpty })
        
        tasks.append(Task(taskText))
    }

    func removeTask(_ task: Task) {
        guard !task.text.isEmpty else {return}
        
        if tasks.count == 1 { // Prevent deletion of all tasks.
            addTask()
        }
        tasks.removeAll(where: { $0 == task })
    }
    
    private enum CodingKeys : String, CodingKey {
        case tasks
    }
   
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(tasks, forKey: .tasks)
    }
   
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        tasks = try values.decode([Task].self, forKey: .tasks)
    }
}

class Task: Hashable, ObservableObject, Codable {
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
    
    static func == (lhs: Task, rhs: Task) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    private enum CodingKeys : String, CodingKey {
        case id
        case text
        case state
    }
   
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(text, forKey: .text)
        try container.encode(state, forKey: .state)
    }
   
    required init(from decoder:Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(UUID.self, forKey: .id)
        text = try values.decode(String.self, forKey: .text)
        state = try values.decode(Double.self, forKey: .state)
    }
}

func readTasks() -> TaskDatabase {
    
    let myTaskForTheDay = TaskModel([
        Task("Wake up this morning"),
        Task("Eat breakfast"),
        Task("Spin(or) georg"),
        Task("Go to the gym :)")
    ])
    
    return TaskDatabase(tasks: myTaskForTheDay)
}
