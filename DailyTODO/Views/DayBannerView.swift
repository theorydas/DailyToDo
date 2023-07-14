import SwiftUI

struct DayBannerView: View {
    @Environment(\.colorScheme) var colorScheme

    @StateObject var day: Day
    
    var body: some View {
        HStack {
            Text(day.dayName)
            Text(day.fullName)
        }
        .shadow(color: shadowColor, radius: 5)
        .padding(.horizontal)
        .padding(.top, -15)
        Divider()
    }

    var shadowColor: Color {
        return colorScheme == .dark ? .black : .white
    }
}
