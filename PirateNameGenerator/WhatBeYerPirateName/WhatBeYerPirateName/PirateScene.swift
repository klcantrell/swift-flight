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
        let isWide = contextWidth > contextHeight
        let waveAnimationOffset = isWide ? contextHeight * 1.2 : contextWidth * 1.2
        let waveStaticOffset: CGFloat = isWide ? -100 : -200
        
        return VStack {
            ZStack {
                if !shouldAnimate {
                    Image("waves")
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .offset(x: waveStaticOffset)
                }
                
                Image("waves")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200)
                    .offset(x: shouldAnimate ? waveAnimationOffset : waveStaticOffset)
                    .animation(shouldAnimate ? .linear(duration: 10) : Animation.default)
                    .opacity(shouldAnimate ? 1 : 0)
                    .animation(nil)
            }
            .offset(y: isWide ? 80 : 40)
            
            ZStack {
                if !shouldAnimate {
                    Image("pirate-ship")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 110)
                }
                
                Image("pirate-ship")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 110)
                    .offset(y: shouldAnimate ? -10 : 0)
                    .animation(shouldAnimate ? Animation.easeInOut(duration: 0.4).repeatForever(autoreverses: true) : Animation.default)
                    .opacity(shouldAnimate ? 1 : 0)
                    .animation(nil)
            }
            .offset(y: isWide ? -130 : -180)
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
