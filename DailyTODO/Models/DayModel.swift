import Foundation

struct DayModel {
    var dayInfo: [String: String] {
        return [
            "dayNumber": "dd",
            "dayName": "EEEE",
            "fullDate": "dd MMMM yyyy",
        ]
    }

    func getDayInfo(deltaDay: Int = 0, type: String) -> String {
        let deltaDay = Double(deltaDay * 60 * 60 * 24) // Convert days to seconds
        let date = Date(timeIntervalSinceNow: deltaDay)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dayInfo[type] ?? "dd MMMM yyyy" // Fallback to fullDate
        return dateFormatter.string(from: date)
    }
}
