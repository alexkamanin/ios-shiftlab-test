final class ContestRepositoryImpl: ContestRepository {

    private final let api: ContestApi
    private final let converter: ContestConverter

    init(api: ContestApi, converter: ContestConverter) {
        self.api = api
        self.converter = converter
    }

    func getAll() async throws -> [Contest] {
        try await api.getAll()
            .map(converter.convert)
    }
}
