import UIKit

final class AuthAssembly {

    struct Dependencies {
        let setUserUseCase: SetUserUseCase
        let setNeedShowWelcomeGuideUseCase: SetNeedShowWelcomeGuideUseCase
        let nameValidator: NameValidator
        let passwordValidator: PasswordValidator
        let birthDateValidator: BirthDateValidator
    }

    struct Routings {
        let toFeed: () -> Void
    }

    static func makeModule(dependencies: Dependencies, routings: Routings) -> Module {
        let router = AuthRouterImpl(
            toFeed: routings.toFeed
        )
        let presenter = AuthPresenter(
            setUserUseCase: dependencies.setUserUseCase,
            setNeedShowWelcomeGuideUseCase: dependencies.setNeedShowWelcomeGuideUseCase,
            nameValidator: dependencies.nameValidator,
            passwordValidator: dependencies.passwordValidator,
            birthDateValidator: dependencies.birthDateValidator,
            router: router
        )
        let viewController = AuthViewController(presenter: presenter)

        return Module(viewController: viewController)
    }
}
