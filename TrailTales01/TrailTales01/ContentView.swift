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
    
    // State to control the navigation
    @State private var isNavigating: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Show the map with annotations
                MapView(region: $region, locationManager: locationManager, places: places, selectedPlace: $selectedPlace, isNavigating: $isNavigating)
                    .edgesIgnoringSafeArea(.all) // Makes the map take up the entire screen
                
                // Navigate to PlaceDetailView when a place is selected
                NavigationLink(
                    destination: PlaceDetailView(place: selectedPlace ?? places.first!), // Safe unwrapping with default
                    isActive: $isNavigating,
                    label: { EmptyView() }
                )
            }
            //.navigationTitle("Copenhagen Sights") // Set the navigation title
            .onAppear {
                // Update the region when the user's location changes
                if let userLocation = locationManager.userLocation {
                    region.center = userLocation.coordinate
                    findClosestPlace(userLocation: userLocation)
                }
            }
            .onChange(of: locationManager.userLocation) { newLocation in
                if let userLocation = newLocation {
                    region.center = userLocation.coordinate
                    findClosestPlace(userLocation: userLocation)
                }
            }
        }
    }
    
    // Function to find the closest place
    private func findClosestPlace(userLocation: CLLocation) {
        var closestDistance: CLLocationDistance = .greatestFiniteMagnitude
        var closest: Place? = nil
        
        for place in places {
            let placeLocation = CLLocation(latitude: place.coordinate.latitude, longitude: place.coordinate.longitude)
            let distance = userLocation.distance(from: placeLocation)
            
            if distance < closestDistance {
                closestDistance = distance
                closest = place
            }
        }
        
        selectedPlace = closest
    }
}

// Preview provider for SwiftUI previews
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView() // Preview the ContentView
    }
}
