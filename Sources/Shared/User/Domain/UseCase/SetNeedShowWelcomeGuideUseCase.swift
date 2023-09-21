final class SetNeedShowWelcomeGuideUseCase {

    private let repository: UserMetaDataRepository

    init(repository: UserMetaDataRepository) {
        self.repository = repository
    }

    func callAsFunction(_ show: Bool) {
        let metaData = UserMetaData(needShowWelcomeGuide: show)
        repository.set(metaData)
    }
}
