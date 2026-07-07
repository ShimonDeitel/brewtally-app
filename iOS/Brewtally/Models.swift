import Foundation

struct BrewEntry: Identifiable, Codable, Equatable {
    let id: UUID
    var bean: String
    var method: String
    var ratio: String
    var rating: Int
    var date: Date

    init(id: UUID = UUID(), bean: String = "", method: String = "", ratio: String = "", rating: Int = 0, date: Date = Date()) {
        self.id = id
        self.bean = bean
        self.method = method
        self.ratio = ratio
        self.rating = rating
        self.date = date
    }
}
