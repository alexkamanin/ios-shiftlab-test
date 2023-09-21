import Foundation

final class ContestDateConverter {

    private var fullDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter
    }

    private var simpleDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss 'UTC'"
        return dateFormatter
    }

    func convert(_ from: String) -> Date? {
        return fullDateFormatter.date(from: from)
            ?? simpleDateFormatter.date(from: from)
    }
}
