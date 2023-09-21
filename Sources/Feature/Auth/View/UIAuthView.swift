import SnapKit
import UIKit

final class UIAuthView: UIView {

    private var bottomSafeAreaConstraint: SnapKit.Constraint?
    private final let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Dimens.space24
        return stackView
    }()
    private final let scrollView = UIScrollView()
    private final let contentView = UIView()
    private final let buttonContentView: UIView = {
        let view = UIView()
        view.addTopBorder(in: .systemGray5, width: Dimens.space1)
        view.backgroundColor = .systemBackground
        return view
    }()

    final let datePickerView: UIDatePicker = UIDatePicker()
    final let firstNameView = UIEditLine()
    final let lastNameView = UIEditLine()
    final let dateView = UIEditLine()
    final let passwordView = UIEditLine(type: .secure)
    final let confirmPasswordView = UIEditLine(type: .secure)
    final let submitview = UIPrimaryButton()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureDatePicker()
        self.setupSubviews()
        self.setupConstraints()
        self.setupListeners()
    }

    private func configureDatePicker() {
        if #available(iOS 13.4, *) {
            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didDoneDate))
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            toolbar.setItems([flexSpace, doneButton], animated: true)
            self.dateView.inputAccessoryView = toolbar

            self.datePickerView.datePickerMode = .date
            self.datePickerView.preferredDatePickerStyle = .wheels
            self.dateView.inputView = datePickerView
        } else {
            self.dateView.keyboardType = .numberPad
        }
    }

    @objc
    private func didDoneDate() {
        self.dateView.endEditing(true)
    }

    private func setupSubviews() {
        self.addSubview(self.scrollView)

        self.scrollView.addSubview(self.contentView)

        self.contentView.addSubview(self.stackView)

        self.stackView.addArrangedSubview(self.firstNameView)
        self.stackView.addArrangedSubview(self.lastNameView)
        self.stackView.addArrangedSubview(self.dateView)
        self.stackView.addArrangedSubview(self.passwordView)
        self.stackView.addArrangedSubview(self.confirmPasswordView)

        self.buttonContentView.addSubview(self.submitview)
        self.addSubview(self.buttonContentView)
    }

    private func setupConstraints() {
        self.contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        self.stackView.snp.makeConstraints { make in
            make.edges.equalTo(self.scrollView.contentLayoutGuide).inset(Dimens.space16)
        }
        self.scrollView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(self.submitview.snp.top)
        }
        self.submitview.snp.makeConstraints { make in
            make.top.equalTo(self.buttonContentView).inset(Dimens.space8)
            make.bottom.equalTo(self.buttonContentView).inset(Dimens.space8)
            make.leading.trailing.equalTo(self.buttonContentView).inset(Dimens.space16)
        }
        self.buttonContentView.snp.makeConstraints { make in
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
            bottomSafeAreaConstraint = make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).constraint
        }
    }

    private func setupListeners() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc
    private func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey],
              let keyboardFrameValue = keyboardFrame as? NSValue
        else {
            return
        }
        let keyboardRectangle = keyboardFrameValue.cgRectValue
        bottomSafeAreaConstraint?.update(inset: keyboardRectangle.height - self.safeAreaInsets.bottom)
    }

    @objc
    private func keyboardWillHide(notification: NSNotification) {
        bottomSafeAreaConstraint?.update(inset: Dimens.zero)
    }
}
