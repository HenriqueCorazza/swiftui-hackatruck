import SwiftUI

struct Init: View {
    @State private var animate = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blueHacka, Color.blueFarma]),
                           startPoint: .topTrailing,
                           endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                Image("Logo")
                    .resizable()
                    .aspectRatio(1/1, contentMode: .fit)
                    .frame(width: 150)
                    .padding()
                    .opacity(animate ? 1 : 0)
                    .scaleEffect(animate ? 1.0 : 0.8)
                    .animation(.easeOut(duration: 1.0), value: animate)
                
                Text("Seu aplicativo para controle de medicamentos")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .font(.custom("Georgia", size: 20))
                    .bold()
                    .opacity(animate ? 1 : 0)
                    .animation(.easeOut(duration: 1.5).delay(0.3), value: animate)
            }
        }
        .onAppear {
            animate = true
        }
    }
}
