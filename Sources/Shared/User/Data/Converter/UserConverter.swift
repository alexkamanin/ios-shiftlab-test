final class UserConverter {

    func convert(_ from: User) -> UserModel {
        UserModel(
            firstName: from.firstName,
            lastName: from.lastName
        )
    }

    func revert(_ from: UserModel) -> User {
        User(
            firstName: from.firstName,
            lastName: from.lastName
        )
    }
}
