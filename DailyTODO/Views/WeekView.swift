import SwiftUI

struct WeekView: View {
    @ObservedObject var taskListDay: Day
    
    var body: some View {
        Divider()
        .overlay {
            HStack(spacing: 25) {
                ForEach(-1..<5) { i in
                    let deltaDay = Double(i * 60 * 60 * 24) // Convert days to seconds
                    let date = Date(timeIntervalSinceNow: deltaDay)
                    let bubbleDay = Day(date: date)
                    
                    CalendarBubble(bubbleDay: bubbleDay, taskListDay: taskListDay)
                }
            }
        }
        .padding(.top, 40)
        .padding(.bottom, 15)
    }
}


struct CalendarBubble: View {
    var bubbleDay: Day
    @ObservedObject var taskListDay: Day
    
    init(bubbleDay: Day, taskListDay: Day) {
        self.bubbleDay = bubbleDay
        self.taskListDay = taskListDay
    }
    var body: some View {
        let dayInitial = bubbleDay.dayName.prefix(1)
        let dayNumber = bubbleDay.dayNumber
        let isToday = bubbleDay == Day()
        let isSelected = bubbleDay == taskListDay
        
        let bubbleColor: Color = isToday ? .accentColor : .white
        
        VStack{
            Text(dayInitial)
            Circle()
                .frame(width: 25, height: 25)
                .foregroundColor(isSelected ? bubbleColor.opacity(0.8) : bubbleColor.opacity(0.1))
//                .opacity(isSelected ? 0.8 : 0.1)
                .overlay {
                    Text(dayNumber)
                        .foregroundColor(isSelected ? .black : .white)
                }
                .onTapGesture { taskListDay.date = bubbleDay.date }
        }.padding(.top, -28)
    }
}
