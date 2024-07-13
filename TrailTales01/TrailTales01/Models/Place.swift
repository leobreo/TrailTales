import Foundation
import CoreLocation

// A model representing a place with an id, name, description, and coordinate
struct Place: Identifiable {
    var id: UUID // Unique identifier for the place
    var name: String // Name of the place
    var description: String // Description of the place
    var coordinate: CLLocationCoordinate2D // Geographic coordinates
}
