import SwiftUI

struct DayListView: View {
    var DaysInFuture: Int
    
    var body: some View {
        VStack {
            DayListBanner(DaysInFuture: DaysInFuture)
            Divider().padding(.bottom, 5)
            VStack(alignment: .leading) {
                TaskTodo(elementText: "This is an amazing day. Please be happy! :)aaaaa")
                ForEach(0..<10) { i in
                    TaskTodo(elementText: "Generic task \(i+1)")
                }
            }
            Spacer()
        }
        .frame(width: 300, height: 360)
        .ignoresSafeArea()
    }
}

struct DayListBanner: View {
    @Environment(\.colorScheme) var colorScheme
    
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

struct TaskTodo: View {
    @State var elementText: String = ""
    
    @State private var isHovered: Bool = false
    @State private var inEditMode: Bool = false
    @State private var buttonState: Double = 0
    
    var body: some View {
        HStack{
            Image(systemName: buttonState == 0 ? "circle" : "circle.fill")
                .foregroundColor(.accentColor)
                .opacity(buttonState == 0 ? 1 : 0.8)
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
        .onTapGesture {buttonState = buttonState == 0 ? 1 : 0}
//        .onHover(perform: {_hovered in isHovered = _hovered})
        .onHover(perform: {_hovered in isHovered = _hovered})
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DayListView(DaysInFuture: 0)
    }
}
