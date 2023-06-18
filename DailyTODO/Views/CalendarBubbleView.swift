import SwiftUI

struct CalendarBubbles: View {
    var body: some View {
        Divider()
        .overlay {
            HStack(spacing: 25) {
                ForEach(-1..<5) { i in
                    let deltaDay = Double(i * 60 * 60 * 24) // Convert days to seconds
                    let date = Date(timeIntervalSinceNow: deltaDay)
                    
                    CalendarBubble(day: Day(date: date))
                }
            }
        }
        .padding(.top, 40)
        .padding(.bottom, 15)
    }
}


struct CalendarBubble: View {
    var day: Day
    
    var body: some View {
        let dayInitial = day.dayName.prefix(1)
        let dayNumber = day.dayNumber
        
        VStack{
            Text(dayInitial)
            Circle()
                .frame(width: 25, height: 25)
                .foregroundColor(day==Day() ? .accentColor : .white)
                .opacity(day==Day() ? 1 : 0.1)
                .overlay {
                    Text(dayNumber)
                        .foregroundColor(day==Day() ? .white : .white)
                }
        }.padding(.top, -28)
    }
}
