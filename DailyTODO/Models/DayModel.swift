import Foundation

extension DateFormatter {
    static func string(from date: Date, format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}

class Day: ObservableObject {
    @Published var date: Date
    
    var dayNumber: String { DateFormatter.string(from: date, format: "dd") }
    var monthNumber: String { DateFormatter.string(from: date, format: "MM") }
    var yearNumber: String { DateFormatter.string(from: date, format: "yyyy") }
    var dayName: String { DateFormatter.string(from: date, format: "EEEE") }
    var monthName: String { DateFormatter.string(from: date, format: "MMMM") }
    var fullName: String { DateFormatter.string(from: date, format: "dd MMMM yyyy") }
    
    init(date: Date = Date()) {
        self.date = date
    }
    
    static func == (lhs: Day, rhs: Day) -> Bool {
        return lhs.fullName == rhs.fullName
    }
}
