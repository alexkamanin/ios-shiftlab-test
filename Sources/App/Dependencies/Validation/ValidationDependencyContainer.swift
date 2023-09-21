final class ValidationDependencyContainer {

    lazy var nameValidator = WeakReference<NameValidator> {
        NameValidator()
    }

    lazy var passwordValidator = WeakReference<PasswordValidator> {
        PasswordValidator()
    }

    lazy var birthDateValidator = WeakReference<BirthDateValidator> {
        BirthDateValidator()
    }
}
