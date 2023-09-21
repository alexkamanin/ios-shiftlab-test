final class ContestDependencyContainer {

    private let networkDependencyContainer: NetworkDependencyContainer

    init(networkDependencyContainer: NetworkDependencyContainer) {
        self.networkDependencyContainer = networkDependencyContainer
    }

    lazy var contestApi = SingleReference<ContestApi> {
        ContestApi(
            session: self.networkDependencyContainer.session.get()
        )
    }

    lazy var contestDateConverter = WeakReference<ContestDateConverter> {
        ContestDateConverter()
    }

    lazy var contestConverter = WeakReference<ContestConverter> {
        ContestConverter(
            dateConverter: self.contestDateConverter.get()
        )
    }

    lazy var contestRepository = SingleReference<ContestRepository> {
        ContestRepositoryImpl(
            api: self.contestApi.get(),
            converter: self.contestConverter.get()
        )
    }

    lazy var getContestsUseCase = WeakReference<GetContestsUseCase> {
        GetContestsUseCase(
            repository: self.contestRepository.get()
        )
    }
}
