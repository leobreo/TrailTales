import Foundation
import CoreLocation

// A model representing a place with an id, name, description, and coordinate
struct Place: Identifiable, Equatable {
    var id: UUID
    var name: String
    var description: String
    var coordinate: CLLocationCoordinate2D
    
    // Conform to Equatable
    static func == (lhs: Place, rhs: Place) -> Bool {
        return lhs.id == rhs.id
    }
}
