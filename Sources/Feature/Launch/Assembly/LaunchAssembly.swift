import UIKit

final class LaunchAssembly {

    struct Dependencies {
        let getUserUseCase: GetUserUseCase
    }

    struct Routings {
        let completion: (_ authorized: Bool) -> Void
    }

    static func makeModule(dependencies: Dependencies, routings: Routings) -> Module {
        let router = LaunchRouterImpl(
            completion: routings.completion
        )
        let presenter = LaunchPresenter(
            getUserUseCase: dependencies.getUserUseCase,
            router: router
        )
        let viewController = LaunchViewController(presenter: presenter)

        return Module(viewController: viewController)
    }
}
