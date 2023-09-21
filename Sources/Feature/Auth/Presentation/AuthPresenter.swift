import UIKit

final class AuthPresenter {

    private weak var view: AuthView?
    private let setUserUseCase: SetUserUseCase
    private let setNeedShowWelcomeGuideUseCase: SetNeedShowWelcomeGuideUseCase
    private let nameValidator: NameValidator
    private let passwordValidator: PasswordValidator
    private let birthDateValidator: BirthDateValidator
    private let router: AuthRouter

    private var firstName: String = ""
    private var lastName: String = ""
    private var password: String = ""
    private var confirmPassword: String = ""
    private var birthDate: Date?

    init(
        setUserUseCase: SetUserUseCase,
        setNeedShowWelcomeGuideUseCase: SetNeedShowWelcomeGuideUseCase,
        nameValidator: NameValidator,
        passwordValidator: PasswordValidator,
        birthDateValidator: BirthDateValidator,
        router: AuthRouter
    ) {
        self.setUserUseCase = setUserUseCase
        self.setNeedShowWelcomeGuideUseCase = setNeedShowWelcomeGuideUseCase
        self.nameValidator = nameValidator
        self.passwordValidator = passwordValidator
        self.birthDateValidator = birthDateValidator
        self.router = router
    }

    func attachView(view: AuthView) {
        self.view = view
    }

    func detachView() {
        self.view = nil
    }

    func handleFirstNameInput(_ firstName: String) {
        self.firstName = firstName
        self.view?.resetFirstNameError()
        self.changeSubmitAvailability()
    }

    func handleLastNameInput(_ lastName: String) {
        self.lastName = lastName
        self.view?.resetLastNameError()
        self.changeSubmitAvailability()
    }

    func handlePasswordInput(_ password: String) {
        self.password = password
        self.view?.resetPasswordError()
        self.changeSubmitAvailability()
    }

    func handleConfirmPasswordInput(_ confirmPassword: String) {
        self.confirmPassword = confirmPassword
        self.view?.resetConfirmPasswordError()
        self.changeSubmitAvailability()
    }

    func handleBirthDateSelected(_ date: Date) {
        self.birthDate = date

        let formatter = DateFormatter( )
        formatter.dateFormat = "dd.MM.yyyy"
        let formattedDate = formatter.string(from: date)

        self.view?.resetBirthDateError()
        self.view?.setBirthDate(formattedDate)
        self.changeSubmitAvailability()
    }

    func handleBirthDateInput(_ dateValue: String) {
        let formatter = DateFormatter( )
        formatter.dateFormat = "dd.MM.yyyy"
        let date = formatter.date(from: dateValue)

        self.birthDate = date
        self.view?.resetBirthDateError()
        self.changeSubmitAvailability()
    }

    private func changeSubmitAvailability() {
        let submitAvailable = !self.firstName.trimmingCharacters(in: .whitespaces).isEmpty
            && !self.lastName.trimmingCharacters(in: .whitespaces).isEmpty
            && !self.password.trimmingCharacters(in: .whitespaces).isEmpty
            && !self.confirmPassword.trimmingCharacters(in: .whitespaces).isEmpty
            && self.birthDate != nil

        if submitAvailable {
            self.view?.enableSubmit()
        } else {
            self.view?.disableSubmit()
        }
    }

    func submit() {
        self.view?.disableFields()
        self.view?.disableSubmit()

        let firstNameResult = nameValidator.validate(self.firstName)
        let lastNameResult = nameValidator.validate(self.lastName)
        let passwordResult = passwordValidator.validate(self.password, confirm: self.confirmPassword)
        let birthDateResult = birthDateValidator.validate(self.birthDate)

        let allFieldsValid = firstNameResult == .valid
            && lastNameResult == .valid
            && passwordResult == .valid
            && birthDateResult == .valid

        if allFieldsValid {
            setUserUseCase(firstName: self.firstName, lastName: self.lastName)
            setNeedShowWelcomeGuideUseCase(true)
            router.routeToFeed()
        } else {
            self.view?.enableFields()
            self.view?.enableSubmit()

            handleValidationResults(
                firstNameResult: firstNameResult,
                lastNameResult: lastNameResult,
                passwordResult: passwordResult,
                birthDateResult: birthDateResult
            )
        }
    }

    private func handleValidationResults(
        firstNameResult: NameValidationResult,
        lastNameResult: NameValidationResult,
        passwordResult: PasswordValidationResult,
        birthDateResult: BirthDateValidationResult
    ) {
        if firstNameResult != .valid {
            self.view?.setFirstNameError(firstNameResult)
        }

        if lastNameResult != .valid {
            self.view?.setLastNameError(lastNameResult)
        }

        if passwordResult != .valid && passwordResult == .notConfirmed {
            self.view?.setConfirmPasswordError()
        } else if passwordResult != .valid {
            self.view?.setPasswordError(passwordResult)
        }

        if birthDateResult != .valid {
            self.view?.setBirthDateError()
        }
    }
}
