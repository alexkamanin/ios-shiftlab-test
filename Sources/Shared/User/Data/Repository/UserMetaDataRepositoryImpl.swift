import RealmSwift

final class UserMetaDataRepositoryImpl: UserMetaDataRepository {

    private let converter: UserMetaDataConverter
    private let realm: Realm

    init(converter: UserMetaDataConverter, realm: Realm) {
        self.converter = converter
        self.realm = realm
    }

    func set(_ metaData: UserMetaData) {
        let model = converter.convert(metaData)
        let oldModel = realm.objects(UserMetaDataModel.self).first

        if let oldModel = oldModel {
            updateModel(oldModel: oldModel, newModel: model)
        } else {
            createModel(model)
        }
    }

    private func updateModel(oldModel: UserMetaDataModel, newModel: UserMetaDataModel) {
        do {
            try realm.write {
                oldModel.needShowWelcomeGuide = newModel.needShowWelcomeGuide
            }
        } catch {
            // MARK: ignore
        }
    }

    private func createModel(_ model: UserMetaDataModel) {
        do {
            try realm.write {
                realm.add(model)
            }
        } catch {
            // MARK: ignore
        }
    }

    func get() -> UserMetaData {
        guard let model = realm.objects(UserMetaDataModel.self).first else {
            return UserMetaData.default
        }
        return converter.revert(model)
    }
}
