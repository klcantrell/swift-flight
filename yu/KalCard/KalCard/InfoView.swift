import SwiftUI

struct InfoView: View {
    let text: String
    let imageName: String
    
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color("TitleText"))
            .frame(height: 50)
            .overlay(
                HStack {
                    Image(systemName: imageName)
                        .foregroundColor(Color(red: 0.06, green: 0.74, blue: 0.98))
                    Text(text)
                        .foregroundColor(Color("InfoText"))
                        .fontWeight(.bold)
                }
            )
            .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(.systemBlue)
            InfoView(text: "123-456-7890", imageName: "phone.fill")
        }
        .edgesIgnoringSafeArea(.all)
    }
}
