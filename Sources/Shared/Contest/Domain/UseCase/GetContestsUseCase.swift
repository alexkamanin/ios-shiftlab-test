final class GetContestsUseCase {

    private final let repository: ContestRepository

    init(repository: ContestRepository) {
        self.repository = repository
    }

    func callAsFunction() async throws -> [Contest] {
        try await repository.getAll()
    }
}
