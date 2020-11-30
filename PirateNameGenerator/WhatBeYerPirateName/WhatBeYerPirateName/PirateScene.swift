import SwiftUI

struct PirateScene: View {
    var shouldAnimate: Bool
    var contextHeight: CGFloat
    var contextWidth: CGFloat
    
    init(animateWhen: Bool, contextHeight: CGFloat, contextWidth: CGFloat) {
        self.shouldAnimate = animateWhen
        self.contextHeight = contextHeight
        self.contextWidth = contextWidth
    }
    
    var body: some View {
        VStack {
            ZStack {
                if !shouldAnimate {
                    Image("waves")
                        .resizable()
                        .scaledToFill()
                        .frame(height: contextHeight / 4)
                }
                
                Image("waves")
                    .resizable()
                    .scaledToFill()
                    .frame(height: contextHeight / 4)
                    .offset(x: shouldAnimate ? contextWidth * 1.2 : 0)
                    .animation(shouldAnimate ? .linear(duration: 10) : Animation.default)
                    .opacity(shouldAnimate ? 1 : 0)
                    .animation(nil)
            }
            .offset(y: contextHeight / 20)
            
            ZStack {
                if !shouldAnimate {
                    Image("pirate-ship")
                        .resizable()
                        .frame(width: contextWidth / 4, height: contextHeight / 8)
                }
                
                Image("pirate-ship")
                    .resizable()
                    .frame(width: contextWidth / 4, height: contextHeight / 8)
                    .offset(y: shouldAnimate ? -10 : 0)
                    .animation(shouldAnimate ? Animation.easeInOut(duration: 0.4).repeatForever(autoreverses: true) : Animation.default)
                    .opacity(shouldAnimate ? 1 : 0)
                    .animation(nil)
            }
            .offset(y: -(contextHeight / 5))
        }
    }
}

struct PirateScene_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PirateScene(animateWhen: false, contextHeight: 815, contextWidth: 415)
            PirateScene(animateWhen: false, contextHeight: 415, contextWidth: 815)
                .previewLayout(.fixed(width: 815, height: 415))
        }
    }
}
