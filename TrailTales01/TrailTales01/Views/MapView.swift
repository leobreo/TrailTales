import SwiftUI
import MapKit

// A SwiftUI view that wraps a UIKit MKMapView
struct MapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    @ObservedObject var locationManager: LocationManager
    var places: [Place]
    @Binding var selectedPlace: Place?

    // Create the MKMapView
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = context.coordinator // Set the delegate to the coordinator
        mapView.showsUserLocation = true // Show user's location on the map
        return mapView
    }

    // Update the MKMapView
    func updateUIView(_ view: MKMapView, context: Context) {
        view.setRegion(region, animated: true) // Update the map region
        
        // Remove existing annotations
        view.removeAnnotations(view.annotations)
        
        // Add new annotations for places
        let annotations = places.map { place -> MKPointAnnotation in
            let annotation = MKPointAnnotation()
            annotation.coordinate = place.coordinate
            annotation.title = place.name
            annotation.subtitle = place.description // Add description as subtitle
            return annotation
        }
        view.addAnnotations(annotations)
        
        // Center the map on the user's location if available
        if let userLocation = locationManager.userLocation {
            let userCoordinate = userLocation.coordinate
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let userRegion = MKCoordinateRegion(center: userCoordinate, span: span)
            view.setRegion(userRegion, animated: true)
        }
    }

    // Coordinator to handle MKMapViewDelegate methods
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView

        init(_ parent: MapView) {
            self.parent = parent
        }

        // Customize the annotation view
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation {
                return nil // Use default user location view
            }

            let identifier = "place"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                
                // Add a button to the callout
                let rightButton = UIButton(type: .detailDisclosure)
                annotationView?.rightCalloutAccessoryView = rightButton
            } else {
                annotationView?.annotation = annotation
            }
            
            // Set pin color based on whether it's the closest place
            annotationView?.pinTintColor = (annotation.coordinate.latitude == parent.selectedPlace?.coordinate.latitude &&
                                            annotation.coordinate.longitude == parent.selectedPlace?.coordinate.longitude) ? UIColor.green : UIColor.red
            return annotationView
        }

        // Handle accessory button tap to navigate to detailed view
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            guard let annotation = view.annotation else { return }
            guard let place = parent.places.first(where: { $0.coordinate.latitude == annotation.coordinate.latitude && $0.coordinate.longitude == annotation.coordinate.longitude }) else { return }
            parent.selectedPlace = place // Set the selected place
        }

        // Handle annotation tap
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            guard let annotation = view.annotation else { return }
            // Find the corresponding place for the tapped annotation
            guard let place = parent.places.first(where: { $0.coordinate.latitude == annotation.coordinate.latitude && $0.coordinate.longitude == annotation.coordinate.longitude }) else { return }
            parent.selectedPlace = place // Set the selected place
        }
    }
}
