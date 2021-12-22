import Foundation
import SwiftUI

struct DIContainer: EnvironmentKey {
    
    // MARK: - Properties
    
    let interactors: Interactors
    
    static var defaultValue: Self { Self.default }
    private static let `default` = Self(interactors: .stub)
    
    init(interactors: Interactors) {
        self.interactors = interactors
    }
}

extension EnvironmentValues {
    var injected: DIContainer {
        get { self[DIContainer.self] }
        set { self[DIContainer.self] = newValue }
    }
}
