import SwiftUI

struct NameSheet: View {
    var pirateName: String
    
    var body: some View {
        VStack {
            Image("pirate-flag")
                .resizable()
                .scaledToFit()
            Text(pirateName)
                .font(.custom("Zapfino", size: 24))
        }
    }
}

struct NameSheet_Previews: PreviewProvider {
    static var previews: some View {
        NameSheet(pirateName: "Crab-Legs Kal")
    }
}
