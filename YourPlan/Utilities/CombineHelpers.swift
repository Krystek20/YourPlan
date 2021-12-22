import Combine

extension Publisher {
    func sinkToLoadable(_ completion: @escaping (Loadable<Output>) -> Void) -> AnyCancellable {
        sink(receiveCompletion: { subscriptionCompletion in
            guard let error = subscriptionCompletion.error else { return }
            completion(.failed(error))
        }, receiveValue: { value in
            completion(.loaded(value))
        })
    }
}

extension Subscribers.Completion {
    var error: Failure? {
        switch self {
        case let .failure(error): return error
        default: return nil
        }
    }
}
