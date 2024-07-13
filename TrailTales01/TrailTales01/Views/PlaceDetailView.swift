import SwiftUI
import CoreLocation // Import CoreLocation to use CLLocationCoordinate2D

// A view to display details about a place
struct PlaceDetailView: View {
    // The place to display details for
    var place: Place
    
    var body: some View {
        VStack {
            // Display the name of the place
            Text(place.name)
                .font(.largeTitle) // Set the font to large title
                .padding() // Add padding around the text
            
            // Display the description of the place
            Text(place.description)
                .padding() // Add padding around the text
            
            Spacer() // Add space to push content to the top
        }
        .navigationTitle("Place Details") // Set the navigation title
    }
}

// Preview provider for SwiftUI previews
struct PlaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Provide a sample place for previewing
        PlaceDetailView(place: Place(
            id: UUID(),
            name: "Central Park",
            description: "A large public park in New York City.",
            coordinate: CLLocationCoordinate2D(latitude: 40.785091, longitude: -73.968285)
        ))
    }
}
