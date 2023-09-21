import RealmSwift

final class RealmDependencyContainer {

    lazy var realm = SingleReference<Realm> {
        guard let realm = try? Realm() else { fatalError("Expected realm but was nil") }
        return realm
    }
}
