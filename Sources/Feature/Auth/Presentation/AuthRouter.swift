protocol AuthRouter {

    func routeToFeed()
}

final class AuthRouterImpl: AuthRouter {

    private let toFeed: () -> Void

    init(
        toFeed: @escaping () -> Void
    ) {
        self.toFeed = toFeed
    }

    func routeToFeed() {
        self.toFeed()
    }
}
