import SwiftUI

struct DayListBanner: View {
    @Environment(\.colorScheme) var colorScheme

    var DaysInFuture: Int
    var dayModel = DayModel()
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text( dayModel.getDayInfo(deltaDay: DaysInFuture, type: "dayName"))
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.accentColor)
                        .padding(.top, 26)

                    Text(dayModel.getDayInfo(deltaDay: DaysInFuture, type: "fullDate"))
                }
                .shadow(color: shadowColor, radius: 5)

                Spacer()
            }
            .padding(.horizontal)
        }
    }

    var shadowColor: Color {
        return colorScheme == .dark ? .black : .white
    }
}
