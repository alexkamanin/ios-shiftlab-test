protocol ContestRepository {

    func getAll() async throws -> [Contest]
}
