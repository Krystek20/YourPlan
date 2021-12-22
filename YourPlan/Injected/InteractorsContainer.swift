import Foundation

extension DIContainer {
    struct Interactors {
        let sprintBacklogInteractor: SprintBacklogInteractor
        
        static var stub: Self {
            .init(sprintBacklogInteractor: StubSprintBacklogInteractor())
        }
    }
}
