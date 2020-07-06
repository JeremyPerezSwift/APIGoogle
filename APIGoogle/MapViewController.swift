//
//  MapViewController.swift
//  APIGoogle
//
//  Created by Jérémy Perez on 06/07/2020.
//  Copyright © 2020 Jérémy Perez. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    @IBOutlet weak var mapView: GMSMapView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Google Maps SDK: Compass
        mapView.settings.compassButton = true
        
        // Google Maps SDK: User's location
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }

}
