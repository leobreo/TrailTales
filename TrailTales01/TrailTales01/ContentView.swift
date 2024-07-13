import SwiftUI
import MapKit

// The main content view of the app
struct ContentView: View {
    // State to hold the region displayed on the map
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 55.6761, longitude: 12.5683), // Default center (Copenhagen)
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) // Default zoom level
    )
    
    // StateObject to manage the location updates
    @StateObject private var locationManager = LocationManager()
    
    // State to hold the list of places
    private var places: [Place] = DataService.loadPlaces()
    
    // State to track the selected place
    @State private var selectedPlace: Place? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Show the map with annotations
                MapView(region: $region, locationManager: locationManager, places: places, selectedPlace: $selectedPlace)
                    .edgesIgnoringSafeArea(.all) // Makes the map take up the entire screen
                
                // Navigate to PlaceDetailView when a place is selected
                if let selectedPlace = selectedPlace {
                    NavigationLink(
                        destination: PlaceDetailView(place: selectedPlace),
                        isActive: .constant(true),
                        label: { EmptyView() }
                    )
                }
            }
            .navigationTitle("Copenhagen Sights") // Set the navigation title
            .navigationDestination(isPresented: .constant(selectedPlace != nil)) {
                if let selectedPlace = selectedPlace {
                    PlaceDetailView(place: selectedPlace)
                }
            }
        }
    }
}

// Preview provider for SwiftUI previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView() // Preview the ContentView
    }
}
