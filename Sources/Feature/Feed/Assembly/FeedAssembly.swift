import Alamofire
import UIKit

final class FeedAssembly {

    struct Dependencies {
        let getContestsUseCase: GetContestsUseCase
        let getUserUseCase: GetUserUseCase
        let getNeedShowWelcomeGuideUseCase: GetNeedShowWelcomeGuideUseCase
        let setNeedShowWelcomeGuideUseCase: SetNeedShowWelcomeGuideUseCase
        let clearUserUseCase: ClearUserUseCase
    }

    struct Routings {
        let toAuth: () -> Void
        let toUrl: (_ urlValue: String) -> Void
    }

    static func makeModule(dependencies: Dependencies, routings: Routings) -> Module {
        let router = FeedRouterImpl(
            toAuth: routings.toAuth,
            toUrl: routings.toUrl
        )
        let presenter = FeedPresenter(
            getContestsUseCase: dependencies.getContestsUseCase,
            getUserUseCase: dependencies.getUserUseCase,
            getNeedShowWelcomeGuideUseCase: dependencies.getNeedShowWelcomeGuideUseCase,
            setNeedShowWelcomeGuideUseCase: dependencies.setNeedShowWelcomeGuideUseCase,
            clearUserUseCase: dependencies.clearUserUseCase,
            router: router
        )
        let viewController = FeedViewController(presenter: presenter)

        return Module(viewController: viewController)
    }
}
