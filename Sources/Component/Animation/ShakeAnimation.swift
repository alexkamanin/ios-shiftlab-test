import UIKit

private let animationDuration: TimeInterval = 0.1
private let animationDelay: TimeInterval = 0

private let noTranslation: CGFloat = 0
private let translationLength: CGFloat = 8

extension UIView {

    func shake(completion: (() -> Void)? = nil) {
        self.left { self.right { self.left { self.center { completion?() } } } }
    }

    private func left(completion: (() -> Void)? = nil) {
        UIView.animate(
            withDuration: animationDuration,
            delay: animationDelay,
            options: [.curveEaseOut],
            animations: {
                self.transform = CGAffineTransform(translationX: translationLength, y: 0)
            },
            completion: { _ in
                completion?()
            }
        )
    }

    private func right(completion: (() -> Void)? = nil) {
        UIView.animate(
            withDuration: animationDuration,
            delay: animationDelay,
            options: [.curveEaseOut],
            animations: {
                self.transform = CGAffineTransform(translationX: -translationLength, y: 0)
            },
            completion: { _ in
                completion?()
            }
        )
    }

    private func center(completion: (() -> Void)? = nil) {
        UIView.animate(
            withDuration: animationDuration,
            delay: animationDelay,
            options: [.curveEaseOut],
            animations: {
                self.transform = CGAffineTransform(translationX: noTranslation, y: 0)
            },
            completion: { _ in
                completion?()
            }
        )
    }
}
