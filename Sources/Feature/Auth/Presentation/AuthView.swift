protocol AuthView: AnyObject {

    func enableFields()

    func disableFields()

    func enableSubmit()

    func disableSubmit()

    func setFirstNameError(_ nameResult: NameValidationResult)

    func resetFirstNameError()

    func setLastNameError(_ nameResult: NameValidationResult)

    func resetLastNameError()

    func setPasswordError(_ passwordResult: PasswordValidationResult)

    func resetPasswordError()

    func setConfirmPasswordError()

    func resetConfirmPasswordError()

    func setBirthDate(_ date: String)

    func setBirthDateError()

    func resetBirthDateError()
}
