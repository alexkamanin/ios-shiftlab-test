import SnapKit
import UIKit

final class UILaunchView: UIView {

    private final let progress = UIActivityIndicatorView()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(progress)
        self.progress.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        self.progress.startAnimating()
    }
}
