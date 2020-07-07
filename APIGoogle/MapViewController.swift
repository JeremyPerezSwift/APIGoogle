//
//  MapViewController.swift
//  APIGoogle
//
//  Created by Jérémy Perez on 06/07/2020.
//  Copyright © 2020 Jérémy Perez. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var textSearch: UITextField!

    var placesClient: GMSPlacesClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Google Maps SDK: Compass
        mapView.settings.compassButton = true
        
        // Google Maps SDK: User's location
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    // Present the Autocomplete view controller when the textField is tapped.
    @IBAction func locationTapped(_ sender: Any) {
        gotoPlaces()
    }
    
    func gotoPlaces() {
        textSearch.resignFirstResponder()
        let AutoCompleteController = GMSAutocompleteViewController()
        AutoCompleteController.delegate = self
        present(AutoCompleteController, animated: true, completion: nil)
    }

}

extension MapViewController: CLLocationManagerDelegate {
    
    // Tells the delegate that new location data is available.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Retrieval and display of latitude and longitude
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("location = \(locValue.latitude) \(locValue.longitude)")
    }
}

extension MapViewController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        
        // Get the place name from 'GMSAutocompleteViewController'
        // Then display the name in textField
        print("Place name: \(String(describing: place.name))")
        dismiss(animated: true, completion: nil)
        self.mapView.clear()
        self.textSearch.text = place.name
        
        // Change the position of the map on the location sought in GMSAutocompleteViewController
        let cord2d = CLLocationCoordinate2DMake((place.coordinate.latitude), (place.coordinate.longitude))

        // Changes the marker placed at a particular point on the map surface.
        let maker = GMSMarker()
        maker.position = cord2d
        maker.title = "Location"
        maker.snippet = place.name
        print("Test name: \(String(describing: place.openingHours?.periods))")
        maker.map = self.mapView

        self.mapView.camera = GMSCameraPosition.camera(withTarget: cord2d, zoom: 15)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print(error.localizedDescription)
    }
    
    // Makes AutoCompleteController disappear by pressing cancel
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
    
}
