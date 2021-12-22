import SwiftUI

struct SprintItemRow: View {

    let item: SprintItem
    var itemtUpdated: ((SprintItem) -> Void)?
    let numberFormatter: NumberFormatter = .percentNumberFormatter
    @State private var offsetX: CGFloat = .zero
    @State private var width: CGFloat = .zero
    @State private var previousTranslationWidth: CGFloat = . zero
    @State private var state: ActionState = .closed {
        didSet {
            switch state {
            case .opened:
                offsetX = -110.0
            case .closed:
                offsetX = .zero
            }
        }
    }
    
    private enum ActionState {
        case closed
        case opened
    }
    
    // MARK: - Views
    
    var body: some View {
        ZStack {
            HStack(alignment: .center, spacing: .zero) {
                ZStack {
                    Color.green.opacity(0.5)
                    HStack(spacing: 20.0) {
                        Spacer()
                        Button {
                            itemtUpdated?(item.updated(with: item.done - 1))
                        } label: {
                            Image(systemName: "minus.circle")
                                .font(.system(size: 20.0, weight: .regular, design: .default))
                        }
                        Button {
                            itemtUpdated?(item.updated(with: item.done + 1))
                        } label: {
                            Image(systemName: "plus.circle")
                                .font(.system(size: 20.0, weight: .regular, design: .default))
                        }
                    }
                    .padding(.trailing, 20.0)
                }
                .tint(.black)
            }
            itemRow
                .background(Color.white)
                .offset(x: offsetX)
                .gesture(
                    DragGesture()
                        .onChanged(onChangeGesture(value:))
                        .onEnded(onEndGesture(value:))
                )
        }
    }
    
    private var itemRow: some View {
        VStack(spacing: 15.0) {
            HStack {
                Text(item.title)
                    .font(.system(size: 16.0, weight: .regular, design: .default))
                    .frame(maxWidth: 200.0, alignment: .leading)
                Text(progressString(for: item))
                    .font(.system(size: 16.0, weight: .regular, design: .default))
                    .frame(maxWidth: 60.0)
                Text(percentString(for: item))
                    .font(.system(size: 16.0, weight: .medium, design: .default))
                    .frame(maxWidth: 60.0)
            }
            .padding(.horizontal, 20.0)
            Divider()
                .padding(.horizontal, 20.0)
        }
        .padding(.top, 15.0)
    }
    
    private func progressString(for item: SprintItem) -> String {
        String("\(item.done) / \(item.count)")
    }
    
    private func percentString(for item: SprintItem) -> String {
        let percent = Double(item.done) / Double(item.count)
        return numberFormatter.string(from: NSNumber(value: percent)) ?? "0" + "%"
    }
    
    private func onChangeGesture(value: DragGesture.Value) {
        switch state {
        case .closed:
            guard value.translation.width <= .zero else { return }
            previousTranslationWidth = value.translation.width
            offsetX = value.translation.width
            if offsetX <= -110 {
                offsetX = -110
            }
        case .opened:
            previousTranslationWidth =  value.translation.width
            offsetX = -110 - value.translation.width
            if offsetX >= .zero {
                offsetX = .zero
            } else if offsetX <= -110 {
                offsetX = -110
            }
        }
    }
    
    private func onEndGesture(value: DragGesture.Value) {
        withAnimation {
            state = previousTranslationWidth > value.translation.width ? .opened : .closed
            previousTranslationWidth = .zero
        }
    }
}
