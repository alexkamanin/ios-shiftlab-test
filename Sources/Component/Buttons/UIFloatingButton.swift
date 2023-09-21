import UIKit

final class UIFloatingButton: UIButton {

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.contentEdgeInsets = UIEdgeInsets(top: Dimens.space16, left: Dimens.space32, bottom: Dimens.space16, right: Dimens.space32)
        self.backgroundColor = .systemBlue
        self.layer.cornerRadius = 26
        self.layer.shadowOffset = CGSize(width: 0.5, height: 0.4)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 12
        self.setTitleColor(.systemGray4, for: .normal)
        self.setTitleColor(.lightText, for: .highlighted)
    }
}
