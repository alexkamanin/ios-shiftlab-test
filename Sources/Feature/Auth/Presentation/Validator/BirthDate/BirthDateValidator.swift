import Foundation

final class BirthDateValidator {

    let minimumAgeValue = 18

    func validate(_ birthDate: Date?) -> BirthDateValidationResult {
        guard let birthDate = birthDate else { return .notPresent }
        guard let minimumAge = Calendar.current.date(byAdding: .year, value: -self.minimumAgeValue, to: Date()) else {
            fatalError("Could not determine the date of birth")
        }
        return birthDate < minimumAge ? .valid : .notComingAge
    }
}
