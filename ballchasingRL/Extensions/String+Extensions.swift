import Foundation

extension String {
    func compressDateString() -> String {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = .withFullDate
        guard let today = formatter.date(from: self) else {
            return "invalid date"
        }

        return formatter.string(from: today)
    }
}
