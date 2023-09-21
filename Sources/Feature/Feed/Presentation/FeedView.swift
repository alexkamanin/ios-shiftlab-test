protocol FeedView: AnyObject {

    func showProgress()

    func hideProgress()

    func setContests(_ contests: [Contest])

    func showWelcomeButton()

    func hideWelcomeButton()

    func showWelcomeGuide(_ user: User)

    func showError(_ message: String)
}
