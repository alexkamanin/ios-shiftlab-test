final class GetNeedShowWelcomeGuideUseCase {

    private let repository: UserMetaDataRepository

    init(repository: UserMetaDataRepository) {
        self.repository = repository
    }

    func callAsFunction() -> Bool {
        repository.get().needShowWelcomeGuide
    }
}
