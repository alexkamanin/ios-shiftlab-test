protocol UserMetaDataRepository {

    func set(_ metaData: UserMetaData)

    func get() -> UserMetaData
}
