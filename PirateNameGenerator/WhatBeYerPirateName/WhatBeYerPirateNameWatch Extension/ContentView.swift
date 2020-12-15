import SwiftUI

struct ContentView: View {
    @State private var currentState: GeneratorState = .Empty {
        didSet {
            if currentState == .Named {
                showNameSheet = true
                firstName = ""
            }
        }
    }
    @State private var showNameSheet: Bool = false
    @State private var generatedName: String?
    @State private var firstName: String = ""
    
    let pirateNameService = PirateNameService()
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .center) {
                PirateScene(
                    animateWhen: currentState == .Requesting,
                    contextHeight: geometry.size.height,
                    contextWidth: geometry.size.width
                )
                .opacity(currentState != .Requesting ? 0 : 1)
                
                if currentState != .Requesting {
                    NameInput(text: $firstName, onNameEntered: {
                        currentState = .Requesting
                        pirateNameService.getPirateName(for: firstName, andThen: {
                            currentState = .Named
                            generatedName = $0
                        })
                    })
                    .frame(minWidth: 0, maxWidth: geometry.size.width)
                }
            }
            .frame(minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity,
                    alignment: .center
            )
            .background(
                Image("cannon-fire")
                    .resizable()
                    .scaledToFill()
                    .scaleEffect(CGSize(width: 1.3, height: 1.3))
                    .opacity(0.2)
            )
            .sheet(isPresented: $showNameSheet) {
                NameSheet(pirateName: generatedName ?? "")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
