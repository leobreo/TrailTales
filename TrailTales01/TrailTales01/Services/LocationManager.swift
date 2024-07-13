import Foundation
import CoreLocation

// A class to manage location services
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    // Create an instance of CLLocationManager to handle location updates
    private var locationManager = CLLocationManager()
    
    // Published property to store the user's current location
    @Published var userLocation: CLLocation?
    
    // Initialize the LocationManager
    override init() {
            super.init()
            self.locationManager.delegate = self
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            self.locationManager.distanceFilter = 10 // Update every 10 meters
            self.locationManager.startUpdatingLocation()
        }

    
    // CLLocationManagerDelegate method to handle location updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Get the last location from the locations array
        guard let location = locations.last else { return }
        // Update the userLocation property with the new location
        self.userLocation = location
    }
    
    // CLLocationManagerDelegate method to handle location errors
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Print an error message if the location update fails
        print("Error updating location: \(error.localizedDescription)")
    }
}
