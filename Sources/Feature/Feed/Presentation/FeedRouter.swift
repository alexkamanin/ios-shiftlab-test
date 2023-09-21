protocol FeedRouter {

    func routeToAuth()

    func routeToUrl(_ urlValue: String)
}

final class FeedRouterImpl: FeedRouter {

    private let toAuth: () -> ()
    private let toUrl: (_ urlValue: String) -> ()

    init(
        toAuth: @escaping () -> Void,
        toUrl: @escaping (_ urlValue: String) -> ()
    ) {
        self.toAuth = toAuth
        self.toUrl = toUrl
    }

    func routeToAuth() {
        self.toAuth()
    }

    func routeToUrl(_ urlValue: String) {
        self.toUrl(urlValue)
    }
}
