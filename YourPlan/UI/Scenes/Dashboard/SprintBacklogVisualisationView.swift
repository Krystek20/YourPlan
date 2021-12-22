import SwiftUI

struct BacklogVisualisationView: View {

    let backlog: SprintBacklog
    var backlogUpdated: ((SprintBacklog) -> Void)?
    
    // MARK: - Views
    
    var body: some View {
        VStack(spacing: .zero) {
            HStack {
                Text("Item name")
                    .font(.system(size: 12.0, weight: .regular, design: .default))
                    .foregroundColor(.gray)
                    .frame(maxWidth: 200.0, alignment: .leading)
                Text("Progress")
                    .font(.system(size: 12.0, weight: .medium, design: .default))
                    .foregroundColor(.gray)
                    .frame(maxWidth: 60.0)
                Text("Execution")
                    .font(.system(size: 12.0, weight: .medium, design: .default))
                    .foregroundColor(.gray)
                    .frame(maxWidth: 60.0)
            }
            .padding(.horizontal, 20.0)
            .padding(.bottom, 15.0)
            Divider()
                .padding(.horizontal, 20.0)
            ForEach(backlog.items) { item in
                SprintItemRow(item: item) { itemUpdated in
                    backlogUpdated?(backlog.updated(with: itemUpdated))
                }
            }
        }
    }
}
