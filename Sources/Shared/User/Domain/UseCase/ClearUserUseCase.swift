final class ClearUserUseCase {

    private final let repository: UserRepository

    init(repository: UserRepository) {
        self.repository = repository
    }

    func callAsFunction() {
        repository.clear()
    }
}
