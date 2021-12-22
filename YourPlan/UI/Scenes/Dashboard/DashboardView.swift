//
//  ContentView.swift
//  YourPlan
//
//  Created by Krystian Solarz on 20/12/2021.
//

import SwiftUI
import CoreData

struct DashboardView: View {

    // MARK: - Properties
    
    @State private(set) var backlog: Loadable<SprintBacklog>
    @Environment(\.injected) private var injected: DIContainer
    
    // MARK: - Initialization
    
    init(backlog: Loadable<SprintBacklog> = .notRequested) {
        self._backlog = .init(initialValue: backlog)
    }
    
    // MARK: - Views
    
    var body: some View {
        NavigationView {
            content
                .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private var content: some View {
        switch backlog {
        case .notRequested:
            return AnyView(notRequestedView)
        case .isLoading:
            return AnyView(loadingView)
        case .loaded(let backlog):
            return AnyView(loadedView(backlog))
        case .failed(let error):
            return AnyView(Text("Error: \(error.localizedDescription)"))
        }
    }
}

private extension DashboardView {
    var notRequestedView: some View {
        Text("")
            .onAppear(perform: loadBacklog)
    }
    
    var loadingView: some View {
        ProgressView()
    }
    
    func loadedView(_ backlog: SprintBacklog) -> some View {
        ScrollView(.vertical) {
            BacklogVisualisationView(backlog: backlog) { updatedBacklog in
                self.backlog = .loaded(updatedBacklog)
            }
        }
    }
}

private extension DashboardView {
    func loadBacklog() {
        injected.interactors.sprintBacklogInteractor
            .loadCurrent($backlog)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
