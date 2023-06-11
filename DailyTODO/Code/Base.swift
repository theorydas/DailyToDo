import Foundation

func GetCurretDay(DaysInFuture: Int = 0) -> String {
    let DaysInFuture = Double (DaysInFuture * 60 * 60 * 24)
    let date = Date(timeIntervalSinceNow: DaysInFuture)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE"
    let dayInWeek = dateFormatter.string(from: date)
    
    return dayInWeek
}
