import Foundation

struct SprintItem: Identifiable {
    let id: String
    let count: Int
    let done: Int
    let title: String
    
    init(id: String = UUID().uuidString, count: Int, done: Int, title: String) {
        self.id = id
        self.count = count
        self.done = done
        self.title = title
    }
}

extension SprintItem {
    func updated(with done: Int) -> SprintItem {
        SprintItem(id: id, count: count, done: done, title: title)
    }
}
