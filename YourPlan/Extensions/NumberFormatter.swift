import Foundation

extension NumberFormatter {
    static var percentNumberFormatter: NumberFormatter {
        let percentFormatter = NumberFormatter()
        percentFormatter.numberStyle = .percent
        percentFormatter.multiplier = 100.0
        percentFormatter.minimumFractionDigits = 1
        percentFormatter.maximumFractionDigits = 1
        return percentFormatter
    }
}
