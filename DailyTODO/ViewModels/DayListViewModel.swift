import SwiftUI

class DayListViewModel: ObservableObject {
    @Published var todoTasks = [String]()

    func addNewTask() {
        todoTasks.append("New Task (\(todoTasks.count))")
    }
}
