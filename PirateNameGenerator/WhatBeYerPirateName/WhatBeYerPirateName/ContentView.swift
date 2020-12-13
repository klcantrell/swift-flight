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
                           maxWidth: geometry.size.width > geometry.size.height
                                ? geometry.size.width * 0.6
                                : geometry.size.width * 0.9,
                           alignment: .leading)

                    NameHeader(displayWhen: currentState == .Requesting)
                        .frame(minWidth: 0,
                               maxWidth: .infinity,
                               alignment: .center)
                }
                .offset(y: geometry.size.width > geometry.size.height ? -50 : -100)
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
                #if os(iOS)
                NameSheet(pirateName: generatedName ?? "")
                #else
                DesktopNameView(pirateName: generatedName ?? "")
                #endif
            }
        }
        .background(Color.white)
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
