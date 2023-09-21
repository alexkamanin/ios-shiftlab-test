import Foundation

final class WeakReference<Type> {

    private weak var object: AnyObject?
    private let factory: () -> Type
    private let lock: NSLock = NSLock()

    init(factory: @escaping () -> Type) {
        self.factory = factory
    }

    func get() -> Type {
        self.lock.lock()
        defer { self.lock.unlock() }
        return (self.object as? Type) ?? self.create()
    }

    private func create() -> Type {
        let object = self.factory()
        self.object = object as AnyObject
        return object
    }
}
