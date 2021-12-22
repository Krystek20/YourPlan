import Foundation

struct SprintBacklog {
    let items: [SprintItem]
    let startDate: Date
    let endDate: Date
}

extension SprintBacklog {
    func updated(with item: SprintItem) -> SprintBacklog {
        var updatedItems = items
        updatedItems.removeAll(where: { $0.id == item.id })
        updatedItems.append(item)
        return SprintBacklog(items: updatedItems, startDate: startDate, endDate: endDate)
    }
}
