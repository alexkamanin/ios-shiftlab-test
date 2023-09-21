struct ContestModel: Decodable {
    let name: String
    let url: String
    let startTime: String
    let endTime: String

    enum CodingKeys: String, CodingKey {
        case name
        case url
        case startTime = "start_time"
        case endTime = "end_time"
    }
}
