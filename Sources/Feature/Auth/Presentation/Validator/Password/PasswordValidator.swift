import Foundation

final class PasswordValidator {

    private static let pattern: String = {
        let hasOneCapitalCharacter = "(?=.*[A-Z])"
        let hasOneCharacter = "(?=.*[a-z])"
        let hasOneDigit = "(?=.*[0-9])"
        let hasOneSpecialCharacter = "(?=.*\\W)"
        let noHasWhitespaces = "(?!.* )"
        let hasLength = "{8,16}"

        return "^"
            + hasOneCapitalCharacter
            + hasOneCharacter
            + hasOneDigit
            + hasOneSpecialCharacter
            + noHasWhitespaces
            + "."
            + hasLength
            + "$"
    }()

    func validate(_ password: String, confirm: String) -> PasswordValidationResult {
        let results: [PasswordValidationResult] = [
            isPresent(password),
            isCorrectFormat(password),
            isEquals(password, confirm: confirm)
        ]
        let failedResults = results.filter { result in result != .valid }

        return failedResults.first ?? .valid
    }

    private func isPresent(_ password: String) -> PasswordValidationResult {
        let present = !password.trimmingCharacters(in: .whitespaces).isEmpty
        return present ? .valid : .notPresent
    }

    private func isEquals(_ password: String, confirm: String) -> PasswordValidationResult {
        return password == confirm ? .valid : .notConfirmed
    }

    private func isCorrectFormat(_ password: String) -> PasswordValidationResult {
        let range = NSRange(location: 0, length: password.utf16.count)
        let regex = try? NSRegularExpression(pattern: PasswordValidator.pattern)

        if regex?.firstMatch(in: password, options: [], range: range) != nil {
            return .valid
        } else {
            return .incorectFormat
        }
    }
}
