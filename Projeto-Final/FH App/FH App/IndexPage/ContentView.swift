import SwiftUI

struct ContentView: View {
    @State private var showSplash = true
    @State private var animateSplash = false

    var body: some View {
        ZStack {
            // Splash screen
            if showSplash {
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
                            .opacity(animateSplash ? 1 : 0)
                            .scaleEffect(animateSplash ? 1.0 : 0.8)
                            .animation(.easeOut(duration: 1.0), value: animateSplash)

                        Text("Seu aplicativo para controle de medicamentos")
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .font(.custom("Georgia", size: 20))
                            .bold()
                            .opacity(animateSplash ? 1 : 0)
                            .animation(.easeOut(duration: 1.5).delay(0.3), value: animateSplash)
                    }
                }
                .onAppear {
                    animateSplash = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            showSplash = false
                        }
                    }
                }
            } else {
                // TabView com o conteúdo do app
                TabView {
                    DashboardView()
                        .tabItem {
                            Label("Home", systemImage: "house")
                        }
                    AgendaAlarme()
                        .tabItem {
                            Label("Alarme", systemImage: "clock.fill")
                        }
                    Medicamentos()
                        .tabItem {
                            Label("Remédios", systemImage: "pills.fill")
                        }
                    MapaFarmacia()
                        .tabItem {
                            Label("Mapa", systemImage: "map")
                        }
                    Viewscanner()
                        .tabItem { Label("Scanner",systemImage: "doc.text.magnifyingglass") }
                    AddRemedioView()
                        .tabItem{
                        Label("Adicionar", systemImage: "plus")
                    }
                }
                
                .environmentObject(LocationManager())
                .transition(.opacity)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
        .environmentObject(LocationManager())
}
