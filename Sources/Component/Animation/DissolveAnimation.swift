import UIKit

private let transitionDuration = 0.3

extension UIWindow {

    func dissolve(completion: (() -> Void)? = nil) {
        UIView.transition(
            with: self,
            duration: transitionDuration,
            options: [.transitionCrossDissolve],
            animations: {},
            completion: { _ in
                completion?()
            }
        )
    }
}
