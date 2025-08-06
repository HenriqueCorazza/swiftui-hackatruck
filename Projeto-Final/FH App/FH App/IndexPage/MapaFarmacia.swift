import SwiftUI
import MapKit

struct CoordenadaFarmacia: Identifiable {
    let id = UUID()
    let nome: String
    let latitude: Double
    let longitude: Double
}

struct MapaFarmacia: View {
    @EnvironmentObject var locationManager: LocationManager

    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: -22.12345, longitude: -51.38765),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )

    @State private var dynamicPharmacies: [CoordenadaFarmacia] = []
    @State private var hasCenteredOnUser = false
    @State private var userMovedMapManually = false

    var body: some View {
        Map(coordinateRegion: $region, showsUserLocation: true, annotationItems: dynamicPharmacies) { farmacia in
            MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: farmacia.latitude, longitude: farmacia.longitude)) {
                ZStack {
                    Image(systemName: "cross.case")
                        .font(.system(size: 15))
                        .foregroundColor(.blue)
                }
                .onTapGesture {
                    openInAppleMaps(coordinate: CLLocationCoordinate2D(
                        latitude: farmacia.latitude,
                        longitude: farmacia.longitude
                    ))
                }
            }
        }
        .gesture(
            DragGesture()
                .onChanged { _ in
                    userMovedMapManually = true // impede que volte a centralizar
                }
        )
        .ignoresSafeArea(.container, edges: .top)
        .onReceive(locationManager.$lastKnownLocation) { location in
            if let location = location, !hasCenteredOnUser, !userMovedMapManually {
                region.center = location
                searchPharmacies(near: location)
                hasCenteredOnUser = true
            }
        }
    }

    private func searchPharmacies(near coordinate: CLLocationCoordinate2D) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = "Farmácia"
        searchRequest.region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )

        let search = MKLocalSearch(request: searchRequest)
        search.start { response, error in
            guard let response = response else {
                print("Erro: \(error?.localizedDescription ?? "Desconhecido")")
                return
            }

            dynamicPharmacies = response.mapItems.map {
                CoordenadaFarmacia(
                    nome: $0.name ?? "Farmácia",
                    latitude: $0.placemark.coordinate.latitude,
                    longitude: $0.placemark.coordinate.longitude
                )
            }
        }
    }

    private func openInAppleMaps(coordinate: CLLocationCoordinate2D) {
        let placemark = MKPlacemark(coordinate: coordinate)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = "Farmácia"
        mapItem.openInMaps(launchOptions: nil)
    }
}


#Preview {
    MapaFarmacia()
        .environmentObject(LocationManager())
}
