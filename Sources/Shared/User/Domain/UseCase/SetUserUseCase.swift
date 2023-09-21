final class SetUserUseCase {

    private final let repository: UserRepository

    init(repository: UserRepository) {
        self.repository = repository
    }

    func callAsFunction(firstName: String, lastName: String) {
        let user = User(firstName: firstName, lastName: lastName)
        repository.set(user)
    }
}
