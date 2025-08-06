import SwiftUI
import MapKit
import EventKit

struct HomeDashboard: View {
    @EnvironmentObject var locationManager: LocationManager

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -22.12345, longitude: -51.38765),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    @State private var proximoEvento: EKEvent?
    let calendario = EKEventStore()

    let remedios: [Medicamento] = [
        Medicamento(nome: "Ibuprofeno", dose: "20 mg", periodo: "8-8 horas", imagem: "ibuprofeno"),
        Medicamento(nome: "Dipirona", dose: "25 gotas", periodo: "1 vez ao dia", imagem: "dipirona")
    ]

    @State private var farmaciasProximas: [CoordenadaFarmacia] = []

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color.blueHacka, Color.blueFarma]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 30) {

                    // MAPA
                    Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: farmaciasProximas) { farmacia in
                        MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: farmacia.latitude, longitude: farmacia.longitude)) {
                            Image(systemName: "cross.case.fill")
                                .foregroundColor(.blue)
                        }
                    }
                    .frame(height: 200)
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 4)

                    // ALARME
                    VStack(spacing: 8) {
                        Text("Próximo Alarme")
                            .font(.headline)
                            .foregroundColor(.black)

                        if let evento = proximoEvento {
                            Text(evento.title)
                                .font(.subheadline)
                                .foregroundColor(.black)
                            Text(evento.startDate.formatted(date: .abbreviated, time: .shortened))
                                .font(.caption)
                                .foregroundColor(.gray)
                        } else {
                            Text("Nenhum alarme encontrado")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 4)

                    // REMÉDIOS
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Seus Remédios")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(.horizontal)

//                        ScrollView(.horizontal, showsIndicators: false) {
//                            HStack(spacing: 16) {
//                                ForEach(remedios) { remedio in
//                                    VStack(alignment: .leading, spacing: 8) {
//                                        Image(remedio.imagem)
//                                            .resizable()
//                                            .aspectRatio(contentMode: .fill)
//                                            .frame(width: 130, height: 90)
//                                            .clipped()
//                                            .cornerRadius(10)
//
//                                        Text(remedio.nome)
//                                            .font(.headline)
//                                            .foregroundColor(.black)
//                                            .lineLimit(1)
//
//                                        Text("Dose: \(remedio.dose)")
//                                            .font(.subheadline)
//                                            .foregroundColor(.gray)
//
//                                        Text("Período: \(remedio.periodo)")
//                                            .font(.subheadline)
//                                            .foregroundColor(.gray)
//                                    }
//                                    .padding()
//                                    .frame(width: 150)
//                                    .background(Color.white)
//                                    .cornerRadius(16)
//                                    .shadow(color: Color.black.opacity(0.15), radius: 6, x: 0, y: 4)
//                                }
//                            }
//                            .padding(.horizontal)
                        }
                    }
                }
                .padding() // 👉 Padding geral em toda a página
            }
        }
        .onAppear {
            carregarEvento()
            atualizarLocalizacao()
        }
    }

    // MARK: - Funções

    func carregarEvento() {
        calendario.requestAccess(to: .event) { permitido, erro in
            if permitido {
                let agora = Date()
                let depois = Calendar.current.date(byAdding: .day, value: 7, to: agora)!
                let filtro = calendario.predicateForEvents(withStart: agora, end: depois, calendars: nil)
                let eventos = calendario.events(matching: filtro).sorted(by: { $0.startDate < $1.startDate })

                DispatchQueue.main.async {
                    self.proximoEvento = eventos.first
                }
            }
        }
    }

    func atualizarLocalizacao() {
        if let local = locationManager.lastKnownLocation {
            region.center = local
            buscarFarmacias(pertoDe: local)
        }
    }

    func buscarFarmacias(pertoDe local: CLLocationCoordinate2D) {
        let requisicao = MKLocalSearch.Request()
        requisicao.naturalLanguageQuery = "Farmácia"
        requisicao.region = MKCoordinateRegion(center: local, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))

        MKLocalSearch(request: requisicao).start { resposta, erro in
            guard let resposta = resposta else { return }
            farmaciasProximas = resposta.mapItems.map {
                CoordenadaFarmacia(nome: $0.name ?? "Farmácia", latitude: $0.placemark.coordinate.latitude, longitude: $0.placemark.coordinate.longitude)
            }
        }
    }
}


#Preview {
    HomeDashboard()
        .environmentObject(LocationManager())
}
