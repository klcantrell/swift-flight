import SwiftUI

struct DesktopNameView: View {
    @Environment(\.presentationMode) var presentation
    
    var pirateName: String
    
    var body: some View {
        VStack {
            Button("Done", action: {
                self.presentation.wrappedValue.dismiss()
            })
                .frame(minWidth: 0,
                       maxWidth: .infinity,
                       alignment: .leading)
                .padding(.horizontal)
            Image("pirate-flag")
                .resizable()
                .scaledToFit()
            Text(pirateName)
                .font(.custom("Zapfino", size: 24))
        }
        .frame(width: 450, height: 450)
    }
}

struct NameSheet_Previews: PreviewProvider {
    static var previews: some View {
        DesktopNameView(pirateName: "Crab-Legs Kal")
    }
}
