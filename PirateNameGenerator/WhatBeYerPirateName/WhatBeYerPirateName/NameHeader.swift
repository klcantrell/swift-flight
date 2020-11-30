import SwiftUI

struct NameHeader: View {
    var shouldDisplay: Bool
    
    init(displayWhen: Bool) {
        shouldDisplay = displayWhen
    }
    
    var body: some View {
        Text("YER PIRATE NAME BE...")
            .padding()
            .opacity(shouldDisplay ? 1 : 0)
            .font(.custom("Zapfino", size: 20))
    }
}

struct NameHeader_Previews: PreviewProvider {
    static var previews: some View {
        NameHeader(displayWhen: true)
    }
}
