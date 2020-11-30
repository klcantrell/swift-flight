import SwiftUI

struct NameInput: View {
    var text: Binding<String>
    var onNameEntered: () -> Void
    
    var body: some View {
        TextField("First name", text: text, onCommit: onNameEntered)
            .padding()
//            .autocapitalization(.words)
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .background(
                RoundedRectangle(cornerRadius: 50)
            )
    }
}
