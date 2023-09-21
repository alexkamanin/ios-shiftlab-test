import RealmSwift

final class UserRepositoryImpl: UserRepository {

    private let converter: UserConverter
    private let realm: Realm

    init(converter: UserConverter, realm: Realm) {
        self.converter = converter
        self.realm = realm
    }

    func set(_ user: User) {
        let model = converter.convert(user)

        do {
            try realm.write {
                realm.add(model)
            }
        } catch {
            // MARK: ignore
        }
    }

    func get() -> User? {
        guard let model = realm.objects(UserModel.self).first else { return nil }
        return converter.revert(model)
    }

    func clear() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            // MARK: ignore
        }
    }
}
