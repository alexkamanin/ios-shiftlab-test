final class UserDependencyContainer {

    private let realmDependencyContainer: RealmDependencyContainer

    init(realmDependencyContainer: RealmDependencyContainer) {
        self.realmDependencyContainer = realmDependencyContainer
    }

    // MARK: User

    lazy var userConverter = SingleReference<UserConverter> {
        UserConverter()
    }

    lazy var userRepository = SingleReference<UserRepository> {
        UserRepositoryImpl(
            converter: self.userConverter.get(),
            realm: self.realmDependencyContainer.realm.get()
        )
    }

    lazy var getUserUseCase = WeakReference<GetUserUseCase> {
        GetUserUseCase(
            repository: self.userRepository.get()
        )
    }

    lazy var setUserUseCase = WeakReference<SetUserUseCase> {
        SetUserUseCase(
            repository: self.userRepository.get()
        )
    }

    lazy var clearUserUseCase = WeakReference<ClearUserUseCase> {
        ClearUserUseCase(
            repository: self.userRepository.get()
        )
    }

    // MARK: User MetaData

    lazy var userMetaDataConverter = SingleReference<UserMetaDataConverter> {
        UserMetaDataConverter()
    }

    lazy var userMetaDataRepository = SingleReference<UserMetaDataRepository> {
        UserMetaDataRepositoryImpl(
            converter: self.userMetaDataConverter.get(),
            realm: self.realmDependencyContainer.realm.get()
        )
    }

    lazy var getNeedShowWelcomeGuideUseCase = WeakReference<GetNeedShowWelcomeGuideUseCase> {
        GetNeedShowWelcomeGuideUseCase(
            repository: self.userMetaDataRepository.get()
        )
    }

    lazy var setNeedShowWelcomeGuideUseCase = WeakReference<SetNeedShowWelcomeGuideUseCase> {
        SetNeedShowWelcomeGuideUseCase(
            repository: self.userMetaDataRepository.get()
        )
    }
}
