import SwiftUI

struct DayListView: View {
    var DaysInFuture: Int
    
    var body: some View {
        VStack {
            DayListBanner(DaysInFuture: DaysInFuture)
            Divider()
            VStack(alignment: .leading) {
                TaskTodo(ElementText: "This is an amazing day. Please be happy! :)")
                ForEach(0..<10) { i in
                    TaskTodo(ElementText: "Generic TODO \(i+1)")
                }
            }
            Spacer()
        }
        .frame(width: 300, height: 360)
        .ignoresSafeArea()
    }
}

struct DayListBanner: View {
    var DaysInFuture: Int
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text( GetCurretDay(DaysInFuture: DaysInFuture))
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.accentColor)
                        .padding(.top, 26)
                    
                    Text(GetCurrentDate(DaysInFuture: DaysInFuture))
                    //                        .padding(.bottom, 10)
                }
                .shadow(color: .black, radius: .pi)
                
                Spacer()
    func GetCurretDay(DaysInFuture: Int = 0) -> String {
        let DaysInFuture = Double (DaysInFuture * 60 * 60 * 24)
        let date = Date(timeIntervalSinceNow: DaysInFuture)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: date)
        
        return dayInWeek
    }

    func GetCurrentDate(DaysInFuture: Int = 0) -> String {
        // Returns the DD Month YYYY format of the current date
        let DaysInFuture = Double (DaysInFuture * 60 * 60 * 24)
        let date = Date(timeIntervalSinceNow: DaysInFuture)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        let fullDate = dateFormatter.string(from: date)

        return fullDate
    }
}

                HStack{
                    Button(action: {
                        print("LEFT LOL")
                    }) {
                        Image(systemName: "chevron.left")
                            .imageScale(.large)
                    }
                    Button(action: {
                        print("Now")
                    }) {
                        Text("Today")
                    }
                    Button(action: {
                        print("Right LOL")
                    }) {
                        Image(systemName: "chevron.right")
                            .imageScale(.large)
                    }
                }.padding(.top, 50)
            }
            .padding(.horizontal)
        }
    }
}

struct TaskTodo: View {
    @State private var buttonState: Double = 0
    var ElementText: String
    
    var body: some View {
        HStack{
            Button(action: ButtonAction){
                Image(systemName: buttonState == 0 ? "circle" : "circle.fill")
                    .foregroundColor(.accentColor)
                    .opacity(buttonState == 0 ? 1 : 0.5)
            }.buttonStyle(PlainButtonStyle())
            Text(ElementText)
                .opacity(buttonState == 0 ? 1 : 0.5)
        }
    }
    
    func ButtonAction() {
        buttonState = buttonState == 0 ? 1 : 0
        // We chaange the Image of the button depending on the state "circle" for 0, and "checkmark.circle" for 1

         
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DayListView(DaysInFuture: 0)
    }
}

