import Foundation

private let minNameLength = 2

final class NameValidator {

    func validate(_ name: String) -> NameValidationResult {
        let results: [NameValidationResult] = [
            isPresent(name),
            isLatin(name),
            isCorrectLength(name),
            isStartWithCapitalLetter(name)
        ]
        let failedResults = results.filter { result in result != .valid }

        return failedResults.first ?? .valid
    }

    private func isPresent(_ name: String) -> NameValidationResult {
        if !name.trimmingCharacters(in: .whitespaces).isEmpty {
            return .valid
        } else {
            return .notPresent
        }
    }

    private func isCorrectLength(_ name: String) -> NameValidationResult {
        if name.count >= minNameLength {
            return .valid
        } else {
            return .mustHasMoreTwoCharacters
        }
    }

    private func isLatin(_ name: String) -> NameValidationResult {
        let range = NSRange(location: 0, length: name.utf16.count)
        let regex = try? NSRegularExpression(pattern: "^([A-Za-z ])+$")

        if regex?.firstMatch(in: name, options: [], range: range) != nil {
            return .valid
        } else {
            return .mustBeLatin
        }
    }

    private func isStartWithCapitalLetter(_ name: String) -> NameValidationResult {
        let range = NSRange(location: 0, length: name.utf16.count)
        let regex = try? NSRegularExpression(pattern: "^[A-Z]")

        if regex?.firstMatch(in: name, options: [], range: range) != nil {
            return .valid
        } else {
            return .mustStartWithCapitalLetter
        }
    }
}
