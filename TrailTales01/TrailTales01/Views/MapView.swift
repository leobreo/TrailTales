import SwiftUI
import MapKit

// A SwiftUI view that wraps a UIKit MKMapView
struct MapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    @ObservedObject var locationManager: LocationManager
    var places: [Place]
    @Binding var selectedPlace: Place?

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        return mapView
    }

    func updateUIView(_ view: MKMapView, context: Context) {
        view.setRegion(region, animated: true)

        // Remove existing annotations
        view.removeAnnotations(view.annotations)
        
        // Add new annotations for places
        let annotations = places.map { place -> MKPointAnnotation in
            let annotation = MKPointAnnotation()
            annotation.coordinate = place.coordinate
            annotation.title = place.name
            return annotation
        }
        view.addAnnotations(annotations)
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

        // Handle annotation tap
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            guard let annotation = view.annotation else { return }
            guard let place = parent.places.first(where: { $0.coordinate.latitude == annotation.coordinate.latitude && $0.coordinate.longitude == annotation.coordinate.longitude }) else { return }
            parent.selectedPlace = place
        }
    }
}
