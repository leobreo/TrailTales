import Foundation
import CoreLocation

// Service to provide sample places data
class DataService {
    static func loadPlaces() -> [Place] {
        // Return hardcoded places data
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
            ),
            Place(
                id: UUID(), // Unique identifier for the place
                name: "Rosenborg Castle", // Name of the place
                description: "A renaissance castle located in Copenhagen.", // Description of the place
                coordinate: CLLocationCoordinate2D(latitude: 55.6863, longitude: 12.5774) // Geographic coordinates
            ),
            Place(
                id: UUID(), // Unique identifier for the place
                name: "Amalienborg", // Name of the place
                description: "The home of the Danish royal family.", // Description of the place
                coordinate: CLLocationCoordinate2D(latitude: 55.6848, longitude: 12.5937) // Geographic coordinates
            ),
            Place(
                id: UUID(), // Unique identifier for the place
                name: "Christiansborg Palace", // Name of the place
                description: "A palace and government building on the islet of Slotsholmen.", // Description of the place
                coordinate: CLLocationCoordinate2D(latitude: 55.6750, longitude: 12.5761) // Geographic coordinates
            ),
            Place(
                id: UUID(), // Unique identifier for the place
                name: "Copenhagen Opera House", // Name of the place
                description: "The national opera house of Denmark.", // Description of the place
                coordinate: CLLocationCoordinate2D(latitude: 55.6800, longitude: 12.6056) // Geographic coordinates
            ),
            Place(
                id: UUID(), // Unique identifier for the place
                name: "Strøget", // Name of the place
                description: "A pedestrian, car-free shopping area in Copenhagen.", // Description of the place
                coordinate: CLLocationCoordinate2D(latitude: 55.6761, longitude: 12.5735) // Geographic coordinates
            )
        ]
    }
}
