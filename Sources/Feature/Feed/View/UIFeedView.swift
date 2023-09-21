import SnapKit
import UIKit

final class UIFeedView: UIView {

    final let progress = UIActivityIndicatorView()
    final let table = UIContestTableView()
    final let welcomeButton = UIFloatingButton()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setupSubviews()
        self.setupConstraints()
    }

    private func setupSubviews() {
        self.addSubview(progress)
        self.addSubview(table)
        self.addSubview(welcomeButton)
    }

    private func setupConstraints() {
        self.progress.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        self.table.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(self.snp.bottom)
        }
        self.welcomeButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).inset(Dimens.space8)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).inset(Dimens.space16)
        }
    }
}
