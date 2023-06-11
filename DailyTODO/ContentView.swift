import SwiftUI

import SwiftUI

struct DayListView: View {
    var DaysInFuture: Int
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                Spacer()
                Text( GetCurretDay(DaysInFuture: DaysInFuture) )
                    .font(.headline)
                
                Text(GetCurrentDate(DaysInFuture: DaysInFuture))
                    .padding(.top, 1)
                Spacer()
                Image(systemName: "chevron.right")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
            }
            .padding(.horizontal)
            Divider()
        }
        .frame(width: 300, height: 360, alignment: .top)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DayListView(DaysInFuture: 0)
    }
}

