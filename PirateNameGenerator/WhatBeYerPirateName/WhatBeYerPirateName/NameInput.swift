import SwiftUI

struct NameInput: View {
    @Environment(\.colorScheme) var colorScheme
    
    var text: Binding<String>
    var onNameEntered: () -> Void
    
    var body: some View {
        TextField("First name", text: text, onCommit: onNameEntered)
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .background(
                RoundedRectangle(cornerRadius: 50)
                    .fill(colorScheme == .light ? Color.white : Color.black.opacity(0.8))
            )
    }
}
