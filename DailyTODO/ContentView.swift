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
    var State: Double = 0
    var ElementText: String
    
    var body: some View {
        HStack {
            Image(systemName: "circle")
                .foregroundColor(.accentColor)
            Text(ElementText)
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DayListView(DaysInFuture: 0)
    }
}

