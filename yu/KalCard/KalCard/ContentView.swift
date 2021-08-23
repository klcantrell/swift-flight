import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color(red: 0.06, green: 0.74, blue: 0.98)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("me")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150)
                    .clipShape(Circle())
                    .overlay(
                        Circle()
                            .stroke(Color("TitleText"), lineWidth: 5)
                    )
                Text(" Kalalau Cantrell ")
                    .font(Font.custom("Pacifico-Regular", size: 40))
                    .fontWeight(.bold)
                    .foregroundColor(Color("TitleText"))
                Text("iOS Developer")
                    .font(.system(size: 25))
                    .foregroundColor(Color("TitleText"))
                Divider()
                InfoView(text: "123-456-7890", imageName: "phone.fill")
                InfoView(text: "me@hi.com", imageName: "envelope.fill")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
