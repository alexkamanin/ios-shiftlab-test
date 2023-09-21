import UIKit

final class LaunchPresenter {

    private weak var view: LaunchView?
    private final let getUserUseCase: GetUserUseCase
    private final let router: LaunchRouter

    init(
        getUserUseCase: GetUserUseCase,
        router: LaunchRouter
    ) {
        self.getUserUseCase = getUserUseCase
        self.router = router
    }

    func attachView(view: LaunchView) {
        self.view = view
    }

    func detachView() {
        self.view = nil
    }

    func launch() {
        let user = getUserUseCase()
        self.router.complete(user != nil)
    }
}
