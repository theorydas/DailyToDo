import SwiftUI

struct DayListView: View {
    var daysInFuture: Int
    @State private var todoTasks = [String]()

    var body: some View {
        VStack {
            DayListBanner(DaysInFuture: daysInFuture)
            CalendarBubbles()
            List {
                ForEach(todoTasks, id: \.self) { item in
                    TaskTodo(elementText: item)
                }
            }
            Spacer()
            Button(action: {
                todoTasks.append("New Task (\(todoTasks.count))")
            }) {
                Text("Add new task")
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.bottom, -30)
        }
        .frame(width: 298, height: 380)
        .ignoresSafeArea()
    }
}
