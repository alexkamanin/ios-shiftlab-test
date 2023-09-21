import Foundation
import SnapKit
import UIKit

open class UITwoLines: UIView {

    private final let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Dimens.space4
        return stackView
    }()
    private final let imageStartView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    private final let topTextView: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        label.numberOfLines = .zero
        return label
    }()
    private final let bottomTextView: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .darkGray
        label.numberOfLines = .zero
        return label
    }()

    public var topText: String? {
        get { self.topTextView.text }
        set {
            self.topTextView.text = newValue
            topTextView.isHidden = newValue == nil
            remakeConstaints() //
            remakeImageConstraints()
        }
    }

    public var bottomText: String? {
        get { self.bottomTextView.text }
        set {
            self.bottomTextView.text = newValue
            bottomTextView.isHidden = newValue == nil
            remakeConstaints() //
            remakeImageConstraints()
        }
    }

    public var imageStart: UIImage? {
        get { self.imageStartView.image }
        set {
            self.imageStartView.image = newValue
            imageStartView.isHidden = newValue == nil
            remakeConstaints()
        }
    }

    private func remakeImageConstraints() {
        if topText == nil || bottomText == nil {
            imageStartView.snp.remakeConstraints { make in
                make.size.equalTo(Dimens.space32)
                make.leading.equalTo(self).inset(Dimens.space16)
                make.centerY.equalTo(self)
            }
        } else {
            imageStartView.snp.remakeConstraints { make in
                make.size.equalTo(Dimens.space32)
                make.top.equalTo(self).inset(Dimens.space16)
                make.leading.equalTo(self).inset(Dimens.space16)
            }
        }
    }

    private func remakeConstaints() {
        if imageStart == nil {
            stackView.snp.remakeConstraints { make in
                make.top.equalToSuperview().inset(Dimens.space16)
                make.leading.equalTo(self.snp.leading).inset(Dimens.space16)
                make.trailing.equalToSuperview().inset(Dimens.space16)
                make.bottom.equalToSuperview().inset(Dimens.space16)
            }
        } else {
            stackView.snp.remakeConstraints { make in
                make.top.equalToSuperview().inset(Dimens.space16)
                make.leading.equalTo(imageStartView.snp.trailing).inset(-Dimens.space16)
                make.trailing.equalToSuperview().inset(Dimens.space16)
                make.bottom.equalToSuperview().inset(Dimens.space16)
            }
        }
    }

    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)

        self.setupSubviews()
    }

    private func setupSubviews() {
        self.addSubview(imageStartView)
        self.addSubview(stackView)

        stackView.addArrangedSubview(topTextView)
        stackView.addArrangedSubview(bottomTextView)
    }
}
