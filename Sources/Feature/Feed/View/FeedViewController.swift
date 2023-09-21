import UIKit

final class FeedViewController: UIViewController, FeedView {

    private final let mainView = UIFeedView()
    private final let presenter: FeedPresenter

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(presenter: FeedPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        self.view = self.mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupListeners()

        self.presenter.attachView(view: self)
        self.presenter.loadContests()
    }

    private func setupView() {
        self.title = l10n("FEED_TITLE")
        self.mainView.backgroundColor = UIColor.systemBackground
        let active = UIBarButtonItem(
            image: UIImage(named: "LogoutSymbol"),
            style: .plain,
            target: self,
            action: #selector(logoutTapped)
        )
        self.navigationItem.setRightBarButtonItems([active], animated: true)
    }

    private func setupListeners() {
        self.mainView.table.setSelectedListener(self.presenter.openContest)
        self.mainView.welcomeButton.addTarget(self, action: #selector(didButtonClick), for: .touchUpInside)
    }

    @objc
    private func logoutTapped() {
        self.presenter.logout()
    }

    @objc
    private func didButtonClick(_ sender: UIButton) {
        self.presenter.handleWelcomeGuide()
    }

    func showProgress() {
        self.mainView.progress.startAnimating()
        self.mainView.progress.isHidden = false
        self.mainView.table.isHidden = true
        self.mainView.welcomeButton.isHidden = true
    }

    func hideProgress() {
        self.mainView.progress.stopAnimating()
        self.mainView.progress.isHidden = true
    }

    func setContests(_ contests: [Contest]) {
        self.mainView.table.cells = contests
        self.mainView.table.isHidden = contests.isEmpty
    }

    func showWelcomeButton() {
        self.mainView.welcomeButton.setTitle(l10n("WELCOME_BUTTON"), for: .normal)
        self.mainView.welcomeButton.isHidden = false
    }

    func hideWelcomeButton() {
        self.mainView.welcomeButton.isHidden = true
    }

    func showWelcomeGuide(_ user: User) {
        let alert = UIAlertController(
            title: l10n("WELCOME_DIALOG_TITLE"),
            message: l10n("WELCOME_DIALOG_MESSAGE", with: "\(user.firstName) \(user.lastName)"),
            preferredStyle: .alert
        )
        let action = UIAlertAction(title: "❤️", style: .default) { _ in
            self.presenter.processCompletedWelcomeGuide()
        }
        alert.addAction(action)

        self.present(alert, animated: true)
    }

    func showError(_ message: String) {
        let alert = UIAlertController(
            title: l10n("ERROR_MESSAGE"),
            message: message,
            preferredStyle: UIAlertController.Style.alert
        )
        let action = UIAlertAction(
            title: "😢",
            style: .default,
            handler: { _ in
                self.presenter.loadContests()
            }
        )
        alert.addAction(action)
        self.present(alert, animated: true)
    }

    deinit {
        self.mainView.table.removeSelectedListener()
        self.presenter.detachView()
    }
}
