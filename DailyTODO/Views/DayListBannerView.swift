import SwiftUI

struct DayListBanner: View {
    @Environment(\.colorScheme) var colorScheme

    var day: Day
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text( day.dayName)
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.accentColor)
                        .padding(.top, 26)

                    Text(day.fullName)
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
