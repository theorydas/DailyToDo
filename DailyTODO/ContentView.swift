import SwiftUI

var dayInfo: [String: String] {
    return [
        "dayNumber": "dd",
        "dayName": "EEEE",
        "fullDate": "dd MMMM yyyy",
    ]
}

func GetDayInfo(deltaDay: Int = 0, type: String) -> String {
    let deltaDay = Double (deltaDay * 60 * 60 * 24) // Convert days to seconds
    let date = Date(timeIntervalSinceNow: deltaDay)

    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = dayInfo[type] ?? "dd MMMM yyyy" // Fallback to fullDate
    return dateFormatter.string(from: date)
}

struct DayListView: View {
    var DaysInFuture: Int
    @State private var todoTasks = [String]()
    
    var body: some View {
        VStack {
            DayListBanner(DaysInFuture: DaysInFuture)
            CalendarBubbles()
            List {
                ForEach(todoTasks, id: \.self) { item in
                    TaskTodo(elementText: item)
                }
            }
            Spacer()
            Button(action: {
                todoTasks.append("New Task (\(todoTasks.count))")
            }) {
                Text("Add new task")
            }
            .buttonStyle(PlainButtonStyle())
            .padding(.bottom, -30)
        }
        .frame(width: 298, height: 380)
        .ignoresSafeArea()
    }
}

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
    
    var body: some View {
        let dayInitial = GetDayInfo(deltaDay: deltaDays, type: "dayName").prefix(1)
        let dayNumber = GetDayInfo(deltaDay: deltaDays, type: "dayNumber")
        
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

struct DayListBanner: View {
    @Environment(\.colorScheme) var colorScheme
    
    var DaysInFuture: Int
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text( GetDayInfo(deltaDay: DaysInFuture, type: "dayName"))
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.accentColor)
                        .padding(.top, 26)
                    
                    Text(GetDayInfo(deltaDay: DaysInFuture, type: "fullDate"))
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

struct TaskTodo: View {
    @State var elementText: String = ""
    
    @State private var isHovered: Bool = false
    @State private var inEditMode: Bool = false
    @State private var buttonState: Double = 0
    
    var body: some View {
        ZStack {
            HStack{
                Image(systemName: buttonState == 0 ? "circle" : "circle.fill")
                    .foregroundColor(.accentColor)
                    .opacity(buttonState == 0 ? 1 : 0.8)
                    .onTapGesture {buttonState = buttonState == 0 ? 1 : 0}
                if inEditMode {
                    TextField("...", text: $elementText, onCommit: {inEditMode = false})
                        .opacity(buttonState == 0 ? 1 : 0.5)
                        .strikethrough(buttonState == 0 ? false : true)
                        .lineLimit(1)
                } else {
                    Text(elementText)
                        .opacity(buttonState == 0 ? 1 : 0.5)
                        .strikethrough(buttonState == 0 ? false : true)
                        .lineLimit(1)
                }
                Spacer()
                Image(systemName: "square.and.pencil")
                    .padding(.trailing, 5)
                    .opacity(isHovered ? 1 : 0)
                    .onTapGesture {inEditMode = true}
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 10)
            .onHover(perform: {_hovered in isHovered = _hovered})
        }
        .onTapGesture(count: 2) {inEditMode = true}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DayListView(DaysInFuture: 0)
    }
}
