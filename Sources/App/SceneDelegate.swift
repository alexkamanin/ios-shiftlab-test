import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    private let app = App()
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else {
            fatalError("Expected window scene but was nil")
        }

        let window = UIWindow(windowScene: windowScene)
        self.window = window
        app.run(on: window)
    }
}
