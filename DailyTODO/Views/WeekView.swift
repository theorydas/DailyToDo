import SwiftUI

struct WeekView: View {
    @ObservedObject var taskListDay: Day
    
    var body: some View {
        HStack(spacing: 25) {
            ForEach(-1..<5) { i in
                let deltaDay = Double(i * 60 * 60 * 24) // Convert days to seconds
                let date = Date(timeIntervalSinceNow: deltaDay)
                let bubbleDay = Day(date: date)
                
                CalendarBubble(bubbleDay: bubbleDay, taskListDay: taskListDay)
            }
        }
        .padding(.top, 60)
        .padding(.bottom, 15)
    }
}


struct CalendarBubble: View {
    var bubbleDay: Day
    @ObservedObject var taskListDay: Day
    @State var isHovered: Bool = false
    
    init(bubbleDay: Day, taskListDay: Day) {
        self.bubbleDay = bubbleDay
        self.taskListDay = taskListDay
    }
    var body: some View {
        let dayInitial = bubbleDay.dayName.prefix(1)
        let dayNumber = bubbleDay.dayNumber
        let isToday = bubbleDay == Day()
        let isSelected = bubbleDay == taskListDay
        let bubbleColor: Color = isToday ? .accentColor : Color("AntiSystem").opacity(0.8)
        
        VStack{
            Text(dayInitial)
            Circle()
                .frame(width: 25, height: 25)
                .foregroundColor(isSelected ? bubbleColor : .clear)
                .overlay {
                    let canShowHoverCircle = isHovered && !isSelected
                    let canShowTodayCircle = isToday && !isSelected
                    
                    Text(dayNumber)
                        .foregroundColor(isSelected ? Color("System") : Color("AntiSystem"))
                    
                    
                    Circle()
                        .stroke(canShowTodayCircle ? Color.accentColor : .clear, lineWidth: 2)
                        .opacity(0.7)
                    
                    Circle()
                        .stroke(canShowHoverCircle ? Color("AntiSystem") : .clear, lineWidth: 2)
                        .opacity(0.6)
                }
        }.padding(.top, -28)
        .onHover { _hovered in isHovered = _hovered}
        .onTapGesture { taskListDay.date = bubbleDay.date }
    }
}
