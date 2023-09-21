final class UserMetaDataConverter {

    func convert(_ from: UserMetaData) -> UserMetaDataModel {
        UserMetaDataModel(
            needShowWelcomeGuide: from.needShowWelcomeGuide
        )
    }

    func revert(_ from: UserMetaDataModel) -> UserMetaData {
        UserMetaData(
            needShowWelcomeGuide: from.needShowWelcomeGuide
        )
    }
}
