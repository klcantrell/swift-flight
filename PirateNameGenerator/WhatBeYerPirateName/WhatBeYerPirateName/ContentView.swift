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
            VStack(alignment: .center) {
                PirateScene(
                    animateWhen: currentState == .Requesting,
                    contextHeight: geometry.size.height,
                    contextWidth: geometry.size.width
                )
            
                VStack {
                    NameInput(text: $firstName, onNameEntered: {
                        currentState = .Requesting
                        pirateNameService.getPirateName(for: firstName, andThen: {
                            currentState = .Named
                            generatedName = $0
                        })
                    })
                        .frame(minWidth: 0,
                                maxWidth: .infinity,
                                alignment: .leading)

                    NameHeader(displayWhen: currentState == .Requesting)
                        .frame(minWidth: 0,
                                maxWidth: .infinity,
                                alignment: .leading)
                }
                .offset(y: -100)
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
        .background(Color.white)
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
                .environment(\.colorScheme, .light)
            ContentView()
                .environment(\.colorScheme, .dark)
    }
}

// Get orientation: Compare width vs. height, use UI device API
// To set placeholder, use empty placeholder provide a custom placeholder TextField
// Consider set height for ship and waves
