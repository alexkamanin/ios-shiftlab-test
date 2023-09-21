import SnapKit
import UIKit

final class UIEditLine: UIView {

    private enum Metrics {

        static let borderWidth: CGFloat = 1.5
        static let passwordImageWidth: Double = 32.0
        static let passwordImageHeight: Double = 32.0
        static let passwordImageLeadingOffset: CGFloat = 8
        static let textBottomOffset: CGFloat = 4
        static let hintLeadingTralingOffset: CGFloat = 8
        static let backgroundCornerRadius: CGFloat = 8
    }

    enum LineStyle {
        case `default`
        case error

        var tintColor: UIColor {
            switch self {
                case .`default`: return UIColor.systemGray
                case .error: return UIColor.systemRed
            }
        }

        var borderColor: UIColor? {
            switch self {
                case .`default`: return .none
                case .error: return UIColor.systemRed
            }
        }

        var borderWidth: CGFloat {
            switch self {
                case .`default`: return .zero
                case .error: return Metrics.borderWidth
            }
        }
    }

    enum LineType {
        case `default`
        case secure
    }

    // MARK: start:propertes

    private(set) var type: LineType

    var style: LineStyle {
        didSet { self.applyAppearance() }
    }

    private weak var _inputView: UIView?
    override var inputView: UIView? {
        get { self._inputView }
        set {
            self._inputView = newValue
            self.field.inputView = newValue
        }
    }

    private weak var _inputAccessoryView: UIView?
    override var inputAccessoryView: UIView? {
        get { self._inputAccessoryView }
        set {
            self._inputAccessoryView = newValue
            self.field.inputAccessoryView = _inputAccessoryView
        }
    }

    var placeholderText: String? {
        get { self.field.placeholder }
        set { self.field.placeholder = newValue }
    }

    var text: String? {
        get { self.field.text }
        set { self.field.text = newValue }
    }

    var isEnabled: Bool {
        get { self.field.isEnabled }
        set { self.field.isEnabled = newValue }
    }

    var keyboardType: UIKeyboardType {
        get { self.field.keyboardType }
        set { self.field.keyboardType = newValue }
    }

    var hintText: String? {
        get { self.hint.text }
        set { self.hint.text = newValue }
    }

    // MARK: end:propertes

    // MARK: start:subviews

    private final let field = UIInsetsTextField()
    private final let hint: UILabel = {
        $0.numberOfLines = 0
        $0.textColor = .systemRed
        $0.font = .systemFont(ofSize: 14)
        return $0
    }(UILabel())
    private lazy var passwordButton: UIButton = {
        let image = UIImage(named: "EyeFill")
        $0.setImage(image, for: .normal)
        $0.imageView?.contentMode = .scaleAspectFit
        $0.tintColor = LineStyle.default.tintColor
        return $0
    }(UIButton(type: .system))

    // MARK: end:subviews

    // MARK: start:listeners

    var textDidChangeHandler: ((_ text: String?) -> Void)?

    // MARK: end:listeners

    // MARK: init

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(type: LineType = .default, style: LineStyle = .default) {
        self.type = type
        self.style = style
        super.init(frame: .zero)
        self.setupSubviews()
        self.setupConstraints()
        self.setupListeners()
        self.configure()
    }

    private func setupSubviews() {
        self.addSubview(self.field)
        self.addSubview(self.hint)

        if self.type == .secure {
            self.addSubview(self.passwordButton)
        }
    }

    private func setupConstraints() {
        if self.type == .secure {
            self.passwordButton.snp.makeConstraints { make in
                make.size.equalTo(CGSize(width: Metrics.passwordImageWidth, height: Metrics.passwordImageHeight))
                make.trailing.equalToSuperview()
                make.centerY.equalTo(self.field.snp.centerY)
            }
            self.field.snp.makeConstraints { make in
                make.top.leading.equalToSuperview()
                make.bottom.equalTo(self.hint.snp.top).inset(-Metrics.textBottomOffset)
                make.trailing.equalTo(self.passwordButton.snp.leading).inset(-Metrics.passwordImageLeadingOffset)
            }
            self.hint.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(Metrics.hintLeadingTralingOffset)
                make.bottom.equalToSuperview()
            }
        } else {
            self.field.snp.makeConstraints { make in
                make.top.leading.equalToSuperview()
                make.bottom.equalTo(self.hint.snp.top).inset(-Metrics.textBottomOffset)
                make.trailing.equalToSuperview()
            }
            self.hint.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(Metrics.hintLeadingTralingOffset)
                make.bottom.equalToSuperview()
            }
        }
    }

    private func setupListeners() {
        self.field.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        if self.type == .secure {
            self.passwordButton.addTarget(self, action: #selector(didTapPasswordButton), for: .touchUpInside)
        }
    }

    @objc
    private func textFieldDidChange() {
        self.textDidChangeHandler?(self.field.text)
    }

    @objc
    private func didTapPasswordButton() {
        self.field.isSecureTextEntry.toggle()
        self.passwordButton.setImage(
            self.field.isSecureTextEntry ? .init(named: "EyeFill") : .init(named: "EyeSlashFill"),
            for: .normal
        )
    }

    private func configure() {
        self.field.setBackgroundColor(.secondarySystemBackground)
        self.field.setDisabledBackgroundColor(.secondarySystemBackground.withAlphaComponent(0.4))
        self.field.layer.cornerRadius = Metrics.backgroundCornerRadius
        self.field.layer.masksToBounds = true

        if self.type == .secure {
            self.field.isSecureTextEntry = true
            self.field.textContentType = .oneTimeCode
        }

        self.applyAppearance()
    }

    private func applyAppearance() {
        if self.style == .default {
            self.applyDetault()
        } else {
            self.applyError()
        }
    }

    private func applyDetault() {
        self.field.layer.borderWidth = LineStyle.default.borderWidth
        self.field.layer.borderColor = LineStyle.default.borderColor?.cgColor
        self.hint.textColor = LineStyle.default.tintColor
    }

    private func applyError() {
        self.field.layer.borderWidth = LineStyle.error.borderWidth
        self.field.layer.borderColor = LineStyle.error.borderColor?.cgColor
        self.hint.textColor = LineStyle.error.tintColor

        self.field.shake()
    }
}

private final class UIInsetsTextField: UITextField {

    private enum Metrics {

        static let inset: CGFloat = 16
    }

    private let contentInsets = UIEdgeInsets(
        top: Metrics.inset,
        left: Metrics.inset,
        bottom: Metrics.inset,
        right: Metrics.inset
    )

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: contentInsets)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: contentInsets)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: contentInsets)
    }
}

private extension UITextField {

    func setBackgroundColor(_ color: UIColor) {
        let coloredImage = getColoredImage(color)
        self.background = coloredImage
    }

    func setDisabledBackgroundColor(_ color: UIColor) {
        let coloredImage = getColoredImage(color)
        self.disabledBackground = coloredImage
    }

    private func getColoredImage(_ color: UIColor) -> UIImage? {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)

        UIGraphicsBeginImageContext(rect.size)
        defer { UIGraphicsEndImageContext() }

        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.setFillColor(color.cgColor)
        context.fill(rect)

        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
