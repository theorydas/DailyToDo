import SwiftUI

import SwiftUI

struct DayListView: View {
    var DaysInFuture: Int
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "calendar")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Text( GetCurretDay(DaysInFuture: DaysInFuture) )
            }
            Divider()
        }
        .padding()
        .frame(width: 300, height: 360, alignment: .top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DayListView(DaysInFuture: 0)
    }
}

