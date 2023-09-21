protocol UserRepository {

    func set(_ user: User)

    func get() -> User?

    func clear()
}
