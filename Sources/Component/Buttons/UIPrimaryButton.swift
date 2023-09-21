import SnapKit
import UIKit

final class UIPrimaryButton: UIButton {

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.contentEdgeInsets = UIEdgeInsets(
            top: Dimens.space16,
            left: Dimens.space32,
            bottom: Dimens.space16,
            right: Dimens.space32
        )
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(.white, for: .highlighted)
        self.setTitleColor(.systemGray2, for: .disabled)
        self.titleLabel?.font = .boldSystemFont(ofSize: 20)
        self.setBackgroundColor(.systemBlue, for: .normal)
        self.setBackgroundColor(.secondarySystemFill, for: .disabled)
        self.setBackgroundColor(.systemBlue.withAlphaComponent(0.8), for: .highlighted)
        self.layer.cornerRadius = Dimens.cornerRadius12
        self.layer.masksToBounds = true
    }
}

extension UIButton {

    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)

        UIGraphicsBeginImageContext(rect.size)
        defer { UIGraphicsEndImageContext() }

        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)
        context.fill(rect)

        let coloredImage = UIGraphicsGetImageFromCurrentImageContext()
        setBackgroundImage(coloredImage, for: state)
    }
}
