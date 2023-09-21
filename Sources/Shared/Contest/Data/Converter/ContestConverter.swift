final class ContestConverter {

    private let dateConverter: ContestDateConverter

    init(dateConverter: ContestDateConverter) {
        self.dateConverter = dateConverter
    }

    func convert(from: ContestModel) -> Contest {
        Contest(
            name: from.name,
            url: from.url,
            startTime: dateConverter.convert(from.startTime),
            endTime: dateConverter.convert(from.endTime)
        )
    }
}
