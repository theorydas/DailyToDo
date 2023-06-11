import Foundation

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