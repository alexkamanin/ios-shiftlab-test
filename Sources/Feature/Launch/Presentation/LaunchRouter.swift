protocol LaunchRouter {

    func complete(_ authorized: Bool)
}

final class LaunchRouterImpl: LaunchRouter {

    private let completion: (_ authorized: Bool) -> Void

    init(
        completion: @escaping (_ authorized: Bool) -> Void
    ) {
        self.completion = completion
    }

    func complete(_ authorized: Bool) {
        self.completion(authorized)
    }
}
