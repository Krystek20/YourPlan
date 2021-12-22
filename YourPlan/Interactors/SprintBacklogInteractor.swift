import Foundation
import Combine

protocol SprintBacklogInteractor {
    func loadCurrent(_ backlog: LoadableSubject<SprintBacklog>)
}

struct YourPlanSprintBacklogInteractor: SprintBacklogInteractor {
    func loadCurrent(_ backlog: LoadableSubject<SprintBacklog>) {
        
    }
}

struct StubSprintBacklogInteractor: SprintBacklogInteractor {
    func loadCurrent(_ backlog: LoadableSubject<SprintBacklog>) {
        let cancelBag = CancelBag()
        backlog.wrappedValue.setIsLoading(cancelBag: cancelBag)
        
        let item1 = SprintItem(
            count: 7,
            done: 7,
            title: "Książki"
        )
        let item2 = SprintItem(
            count: 3,
            done: 2,
            title: "Trening"
        )
        let item3 = SprintItem(
            count: 2,
            done: 2,
            title: "Ścianka"
        )
        let item4 = SprintItem(
            count: 1,
            done: 0,
            title: "Joga"
        )
        let item5 = SprintItem(
            count: 1,
            done: 0,
            title: "Deutsch - sprechen"
        )
        let item6 = SprintItem(
            count: 1,
            done: 0,
            title: "Deutsch - ubungen"
        )
        let item7 = SprintItem(
            count: 1,
            done: 0,
            title: "Zapisać się do szkoły"
        )
        let item8 = SprintItem(
            count: 1,
            done: 1,
            title: "Msza"
        )
        let item9 = SprintItem(
            count: 14,
            done: 14,
            title: "Modlitwa"
        )
        let item10 = SprintItem(
            count: 1,
            done: 1,
            title: "Sauna"
        )
        let item11 = SprintItem(
            count: 5,
            done: 5,
            title: "Job"
        )
        let item12 = SprintItem(
            count: 1,
            done: 1,
            title: "Lean"
        )
        let newBacklog = SprintBacklog(
            items: [item1, item2, item3, item4, item5, item6, item7, item8, item9, item10, item11, item12],
            startDate: Date(),
            endDate: Date()
        )
//        Just(newBacklog)
        Future<SprintBacklog, Error> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                promise(.success(newBacklog))
            }
        }
        .sinkToLoadable { backlog.wrappedValue = $0 }
        .store(in: cancelBag)
    }
}
