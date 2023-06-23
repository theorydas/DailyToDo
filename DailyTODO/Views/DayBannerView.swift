import SwiftUI

struct DayBannerView: View {
    @Environment(\.colorScheme) var colorScheme

    @StateObject var day: Day
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text( day.dayName)
                        .font(.system(size: 36))
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
