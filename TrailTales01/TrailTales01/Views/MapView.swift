import SwiftUI
import MapKit

// A SwiftUI view that wraps a UIKit MKMapView
struct MapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    @ObservedObject var locationManager: LocationManager
    var places: [Place]
    @Binding var selectedPlace: Place?
    @Binding var closestPlace: Place?
    @Binding var isNavigating: Bool

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
        
        // Refresh the annotation views
        for annotation in view.annotations {
            if let annotationView = view.view(for: annotation) as? MKMarkerAnnotationView {
                if let closestPlace = closestPlace,
                   annotation.coordinate.latitude == closestPlace.coordinate.latitude &&
                   annotation.coordinate.longitude == closestPlace.coordinate.longitude {
                    annotationView.markerTintColor = .green
                } else {
                    annotationView.markerTintColor = .red
                }
            }
        }
    }

    // Coordinator to handle MKMapViewDelegate methods
    func makeCoordinator() -> Coordinator {
        Coordinator(self, isNavigating: $isNavigating)
    }

    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        @Binding var isNavigating: Bool

        init(_ parent: MapView, isNavigating: Binding<Bool>) {
            self.parent = parent
            self._isNavigating = isNavigating
        }

        // Customize the annotation view
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            if annotation is MKUserLocation {
                return nil // Use default user location view
            }

            let identifier = "place"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                
                // Add a button to the callout
                let rightButton = UIButton(type: .detailDisclosure)
                annotationView?.rightCalloutAccessoryView = rightButton
            } else {
                annotationView?.annotation = annotation
            }
            
            // Set marker tint color based on whether it's the closest place
            if let closestPlace = parent.closestPlace,
               annotation.coordinate.latitude == closestPlace.coordinate.latitude &&
               annotation.coordinate.longitude == closestPlace.coordinate.longitude {
                annotationView?.markerTintColor = .green
            } else {
                annotationView?.markerTintColor = .red
            }
            
            return annotationView
        }

        // Handle accessory button tap to navigate to detailed view
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
            guard let annotation = view.annotation else { return }
            guard let place = parent.places.first(where: { $0.coordinate.latitude == annotation.coordinate.latitude && $0.coordinate.longitude == annotation.coordinate.longitude }) else { return }
            parent.selectedPlace = place // Set the selected place
            isNavigating = true // Trigger navigation
        }

        // Handle annotation tap
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            // Just show the callout, no need to set selectedPlace here
        }
    }
}
