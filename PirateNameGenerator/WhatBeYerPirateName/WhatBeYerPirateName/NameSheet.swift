import SwiftUI

struct NameSheet: View {
    @Environment(\.presentationMode) var presentation
    
    var pirateName: String
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack {
                    Image("pirate-flag")
                        .resizable()
                        .scaledToFit()
                    Text(pirateName)
                        .font(.custom("Zapfino", size: 24))
                        .foregroundColor(.black)
                }
                .navigationBarItems(leading: Button("Done", action: { self.presentation.wrappedValue.dismiss() }))
            }
        }
    }
}

struct NameSheet_Previews: PreviewProvider {
    static var previews: some View {
        NameSheet(pirateName: "Crab-Legs Kal")
    }
}
