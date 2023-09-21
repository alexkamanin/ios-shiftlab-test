final class DependencyContainer {

    lazy var network = NetworkDependencyContainer()
    lazy var realm = RealmDependencyContainer()
    lazy var contest = ContestDependencyContainer(networkDependencyContainer: self.network)
    lazy var user = UserDependencyContainer(realmDependencyContainer: self.realm)
    lazy var validation = ValidationDependencyContainer()
}
