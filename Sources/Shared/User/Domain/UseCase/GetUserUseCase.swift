final class GetUserUseCase {

    private final let repository: UserRepository

    init(repository: UserRepository) {
        self.repository = repository
    }

    func callAsFunction() -> User? {
        repository.get()
    }
}
