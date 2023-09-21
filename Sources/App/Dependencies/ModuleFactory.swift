import Alamofire
import UIKit

final class ModuleFactory {

    private let dependencyContainer = DependencyContainer()

    func makeLaunchModule(completion: @escaping (_ authorized: Bool) -> Void) -> Module {
        let dependencies = LaunchAssembly.Dependencies(
            getUserUseCase: self.dependencyContainer.user.getUserUseCase.get()
        )
        let routings = LaunchAssembly.Routings(
            completion: completion
        )

        return LaunchAssembly.makeModule(dependencies: dependencies, routings: routings)
    }

    func makeAuthModule(toFeed: @escaping () -> Void) -> Module {
        let dependencies = AuthAssembly.Dependencies(
            setUserUseCase: self.dependencyContainer.user.setUserUseCase.get(),
            setNeedShowWelcomeGuideUseCase: self.dependencyContainer.user.setNeedShowWelcomeGuideUseCase.get(),
            nameValidator: self.dependencyContainer.validation.nameValidator.get(),
            passwordValidator: self.dependencyContainer.validation.passwordValidator.get(),
            birthDateValidator: self.dependencyContainer.validation.birthDateValidator.get()
        )
        let routings = AuthAssembly.Routings(
            toFeed: toFeed
        )

        return AuthAssembly.makeModule(dependencies: dependencies, routings: routings)
    }

    func makeFeedModule(
        toAuth: @escaping () -> Void,
        toUrl: @escaping (_ urlValue: String) -> Void
    ) -> Module {
        let dependencies = FeedAssembly.Dependencies(
            getContestsUseCase: self.dependencyContainer.contest.getContestsUseCase.get(),
            getUserUseCase: self.dependencyContainer.user.getUserUseCase.get(),
            getNeedShowWelcomeGuideUseCase: self.dependencyContainer.user.getNeedShowWelcomeGuideUseCase.get(),
            setNeedShowWelcomeGuideUseCase: self.dependencyContainer.user.setNeedShowWelcomeGuideUseCase.get(),
            clearUserUseCase: self.dependencyContainer.user.clearUserUseCase.get()
        )
        let routings = FeedAssembly.Routings(
            toAuth: toAuth,
            toUrl: toUrl
        )

        return FeedAssembly.makeModule(dependencies: dependencies, routings: routings)
    }
}
