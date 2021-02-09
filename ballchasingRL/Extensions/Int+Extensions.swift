import Foundation

extension Int {
    func largeNumberToCommaSeperatedString() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value: self)) ?? "0"
    }

    func numberToDigitalTime() -> String {
        let minutes = self / 60
        let seconds = self % 60
        return seconds < 10 ? "\(minutes):0\(seconds)" : "\(minutes):\(seconds)"
    }
}
