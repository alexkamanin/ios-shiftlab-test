import UIKit

final class LaunchViewController: UIViewController, LaunchView {

    private final let mainView = UILaunchView()
    private final let presenter: LaunchPresenter

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(presenter: LaunchPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    override func loadView() {
        self.view = self.mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainView.backgroundColor = UIColor.systemBackground

        self.presenter.attachView(view: self)
        self.presenter.launch()
    }

    deinit {
        self.presenter.detachView()
    }
}
