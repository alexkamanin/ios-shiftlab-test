import RealmSwift

final class UserMetaDataModel: Object {
    @Persisted var needShowWelcomeGuide: Bool

    convenience init(needShowWelcomeGuide: Bool) {
        self.init()
        self.needShowWelcomeGuide = needShowWelcomeGuide
    }
}
