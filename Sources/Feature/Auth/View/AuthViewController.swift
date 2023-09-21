import UIKit
import Veil

private let birthDateMask = Veil(pattern: "##.##.####")

final class AuthViewController: UIViewController, AuthView {

    private final let mainView = UIAuthView()
    private final let presenter: AuthPresenter

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(presenter: AuthPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        self.view = self.mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupListeners()

        presenter.attachView(view: self)
    }

    private func setupView() {
        self.title = l10n("AUTH_TITLE")
        self.mainView.backgroundColor = UIColor.systemBackground
        self.mainView.submitview.setTitle(l10n("AUTH_BUTTON"), for: .normal)
        self.mainView.firstNameView.placeholderText = l10n("FIRST_NAME_PLACEHOLDER")
        self.mainView.lastNameView.placeholderText = l10n("LAST_NAME_PLACEHOLDER")
        self.mainView.dateView.placeholderText = l10n("BIRTH_DATE_PLACEHOLDER")
        self.mainView.passwordView.placeholderText = l10n("PASSWORD_PLACEHOLDER")
        self.mainView.confirmPasswordView.placeholderText = l10n("CONFIRM_PASSWORD_PLACEHOLDER")
        self.disableSubmit()
    }

    private func setupListeners() {
        self.mainView.firstNameView.textDidChangeHandler = { text in
            guard let text = text else { return }
            self.presenter.handleFirstNameInput(text)
        }
        self.mainView.lastNameView.textDidChangeHandler = { text in
            guard let text = text else { return }
            self.presenter.handleLastNameInput(text)
        }
        self.mainView.passwordView.textDidChangeHandler = { text in
            guard let text = text else { return }
            self.presenter.handlePasswordInput(text)
        }
        self.mainView.confirmPasswordView.textDidChangeHandler = { text in
            guard let text = text else { return }
            self.presenter.handleConfirmPasswordInput(text)
        }
        self.mainView.dateView.textDidChangeHandler = { text in
            guard let text = text else { return }
            let maskedText = birthDateMask.mask(input: text, exhaustive: false)
            self.mainView.dateView.text = maskedText
            self.presenter.handleBirthDateInput(maskedText)
        }
        self.mainView.submitview.addTarget(self, action: #selector(submitTapped), for: .touchDown)
        self.mainView.datePickerView.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }

    @objc
    private func submitTapped() {
        self.presenter.submit()
    }

    @objc
    private func dateChanged() {
        let date = self.mainView.datePickerView.date
        self.presenter.handleBirthDateSelected(date)
    }

    func enableFields() {
        self.mainView.firstNameView.isEnabled = true
        self.mainView.lastNameView.isEnabled = true
        self.mainView.passwordView.isEnabled = true
        self.mainView.confirmPasswordView.isEnabled = true
    }

    func disableFields() {
        self.mainView.firstNameView.isEnabled = false
        self.mainView.lastNameView.isEnabled = false
        self.mainView.passwordView.isEnabled = false
        self.mainView.confirmPasswordView.isEnabled = false
    }

    func enableSubmit() {
        self.mainView.submitview.isEnabled = true
    }

    func disableSubmit() {
        self.mainView.submitview.isEnabled = false
    }

    func setFirstNameError(_ nameResult: NameValidationResult) {
        var errorDescription: String? {
            switch nameResult {
                case .mustBeLatin: return l10n("FIRST_NAME_ONLY_LATIN_CHARACTERS_DESCRIPTION")
                case .mustHasMoreTwoCharacters: return l10n("FIRST_NAME_INCORRECT_LENGTH")
                case .mustStartWithCapitalLetter: return l10n("FIRST_NAME_CAPITAL_LETTER_DESCRIPTION")
                default: return nil
            }
        }
        self.mainView.firstNameView.style = .error
        self.mainView.firstNameView.hintText = errorDescription
    }

    func resetFirstNameError() {
        self.mainView.firstNameView.style = .default
        self.mainView.firstNameView.hintText = nil
    }

    func setLastNameError(_ nameResult: NameValidationResult) {
        var errorDescription: String? {
            switch nameResult {
                case .mustBeLatin: return l10n("FIRST_NAME_ONLY_LATIN_CHARACTERS_DESCRIPTION")
                case .mustHasMoreTwoCharacters: return l10n("FIRST_NAME_INCORRECT_LENGTH")
                case .mustStartWithCapitalLetter: return l10n("FIRST_NAME_CAPITAL_LETTER_DESCRIPTION")
                default: return nil
            }
        }
        self.mainView.lastNameView.style = .error
        self.mainView.lastNameView.hintText = errorDescription
    }

    func resetLastNameError() {
        self.mainView.lastNameView.style = .default
        self.mainView.lastNameView.hintText = nil
    }

    func setPasswordError(_ passwordResult: PasswordValidationResult) {
        self.mainView.passwordView.style = .error
        if passwordResult == .incorectFormat {
            self.mainView.passwordView.hintText = l10n("PASSWORD_INCORRECT_FORMAT")
        }
    }

    func resetPasswordError() {
        self.mainView.passwordView.style = .default
        self.mainView.passwordView.hintText = nil
    }

    func setConfirmPasswordError() {
        self.mainView.confirmPasswordView.style = .error
        self.mainView.confirmPasswordView.hintText = l10n("PASSWORD_NO_MATCH")
    }

    func resetConfirmPasswordError() {
        self.mainView.confirmPasswordView.style = .default
        self.mainView.confirmPasswordView.hintText = nil
    }

    func setBirthDate(_ date: String) {
        self.mainView.dateView.text = date
    }

    func setBirthDateError() {
        self.mainView.dateView.style = .error
        self.mainView.dateView.hintText = l10n("BIRTH_DATE_UNDERAGE")
    }

    func resetBirthDateError() {
        self.mainView.dateView.style = .default
        self.mainView.dateView.hintText = nil
    }
}
