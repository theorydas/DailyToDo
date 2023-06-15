import SwiftUI

struct CalendarBubbles: View {
    var body: some View {
        Divider()
        .overlay {
            HStack(spacing: 25) {
                ForEach(-1..<5) { i in
                    CalendarBubble(deltaDays: i)
                }
            }
        }
        .padding(.top, 40)
        .padding(.bottom, 15)
    }
}


struct CalendarBubble: View {
    var deltaDays: Int
    var dayModel = DayModel()
    
    var body: some View {
        let dayInitial = dayModel.getDayInfo(deltaDay: deltaDays, type: "dayName").prefix(1)
        let dayNumber = dayModel.getDayInfo(deltaDay: deltaDays, type: "dayNumber")

        VStack{
            Text(dayInitial)
            Circle()
                .frame(width: 25, height: 25)
                .overlay {
                    Text(dayNumber)
                        .foregroundColor(deltaDays==0 ? .white : .black)
                }
                .foregroundColor(deltaDays==0 ? .accentColor : .white)
                .opacity(deltaDays==0 ? 1 : 0.75)
        }.padding(.top, -28)
    }
}
