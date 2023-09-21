import UIKit

final class FeedPresenter {

    private weak var view: FeedView?
    private final let getContestsUseCase: GetContestsUseCase
    private final let getUserUseCase: GetUserUseCase
    private final let getNeedShowWelcomeGuideUseCase: GetNeedShowWelcomeGuideUseCase
    private final let setNeedShowWelcomeGuideUseCase: SetNeedShowWelcomeGuideUseCase
    private final let clearUserUseCase: ClearUserUseCase
    private final let router: FeedRouter

    init(
        getContestsUseCase: GetContestsUseCase,
        getUserUseCase: GetUserUseCase,
        getNeedShowWelcomeGuideUseCase: GetNeedShowWelcomeGuideUseCase,
        setNeedShowWelcomeGuideUseCase: SetNeedShowWelcomeGuideUseCase,
        clearUserUseCase: ClearUserUseCase,
        router: FeedRouter
    ) {
        self.getContestsUseCase = getContestsUseCase
        self.getUserUseCase = getUserUseCase
        self.getNeedShowWelcomeGuideUseCase = getNeedShowWelcomeGuideUseCase
        self.setNeedShowWelcomeGuideUseCase = setNeedShowWelcomeGuideUseCase
        self.clearUserUseCase = clearUserUseCase
        self.router = router
    }

    func attachView(view: FeedView) {
        self.view = view
    }

    func detachView() {
        self.view = nil
    }

    func loadContests() {
        self.view?.showProgress()

        Task {
            do {
                let contests = try await getContestsUseCase()
                self.handleContestsLoaded(contests)
            } catch let error {
                DispatchQueue.main.async {
                    self.view?.showError(error.localizedDescription)
                }
            }
        }
    }

    private func handleContestsLoaded(_ contests: [Contest]) {

        DispatchQueue.main.async {
            self.view?.hideProgress()
            self.view?.setContests(contests)

            let needShowWelcomeGuide = self.getNeedShowWelcomeGuideUseCase()
            if needShowWelcomeGuide {
                self.view?.showWelcomeButton()
            } else {
                self.view?.hideWelcomeButton()
            }
        }
    }

    func openContest(_ contest: Contest) {
        router.routeToUrl(contest.url)
    }

    func handleWelcomeGuide() {
        guard let user = getUserUseCase() else { fatalError("Expected user but was nil") }
        self.view?.showWelcomeGuide(user)
    }

    func processCompletedWelcomeGuide() {
        setNeedShowWelcomeGuideUseCase(false)
        self.view?.hideWelcomeButton()
    }

    func logout() {
        clearUserUseCase()
        router.routeToAuth()
    }
}
