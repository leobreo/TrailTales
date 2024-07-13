import Foundation
import CoreLocation

// Service to provide sample places data
class DataService {
    // Static function to load sample places data
    static func loadPlaces() -> [Place] {
        // Returns an array of Place objects
        return [
            Place(
                            id: UUID(), // Unique identifier for the place
                            name: "Nyhavn", // Name of the place
                            description: "A 17th-century waterfront, canal and entertainment district.", // Description of the place
                            coordinate: CLLocationCoordinate2D(latitude: 55.6797, longitude: 12.5875) // Geographic coordinates
                        ),
                        Place(
                            id: UUID(), // Unique identifier for the place
                            name: "The Little Mermaid", // Name of the place
                            description: "A bronze statue by Edvard Eriksen, depicting a mermaid.", // Description of the place
                            coordinate: CLLocationCoordinate2D(latitude: 55.6929, longitude: 12.5996) // Geographic coordinates
                        ),
                        Place(
                            id: UUID(), // Unique identifier for the place
                            name: "Tivoli Gardens", // Name of the place
                            description: "An amusement park and pleasure garden.", // Description of the place
                            coordinate: CLLocationCoordinate2D(latitude: 55.6734, longitude: 12.5681) // Geographic coordinates
                        )
        ]
    }
}
