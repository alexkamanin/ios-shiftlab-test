import UIKit

final class App {

    private let moduleFactory = ModuleFactory()
    private weak var window: UIWindow?

    func run(on window: UIWindow) {
        self.window = window
        self.showLaunch()
    }

    private func showLaunch() {
        let launchModule = moduleFactory.makeLaunchModule { authorized in
            authorized ? self.showFeed() : self.showAuth()
        }
        let launchController = launchModule.viewController

        self.window?.rootViewController = launchController
        self.window?.makeKeyAndVisible()
    }

    private func showAuth() {
        guard let window = window else { fatalError("Expected window but was nil") }

        let toFeedClosure: () -> Void = { self.showFeed() }

        let authModule = moduleFactory.makeAuthModule(
            toFeed: toFeedClosure
        )
        let authController = authModule.viewController

        window.rootViewController = UINavigationController(rootViewController: authController)
        window.makeKeyAndVisible()
        window.dissolve()
    }

    private func showFeed() {
        guard let window = window else { fatalError("Expected window but was nil") }

        let toAuthClosure: () -> Void = { self.showAuth() }
        let toUrlClosure: (_ urlValue: String) -> Void = { urlValue in
            self.openUrl(urlValue: urlValue)
        }

        let feedModule = moduleFactory.makeFeedModule(
            toAuth: toAuthClosure,
            toUrl: toUrlClosure
        )

        let feedController = UINavigationController(rootViewController: feedModule.viewController)

        window.rootViewController = feedController
        window.makeKeyAndVisible()
        window.dissolve()
    }

    private func openUrl(urlValue: String) {
        guard let url = URL(string: urlValue) else {
            fatalError("\"\(urlValue)\" is not supported")
        }
        UIApplication.shared.open(url)
    }
}
