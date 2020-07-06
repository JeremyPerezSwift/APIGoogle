//
//  ViewController.swift
//  APIGoogle
//
//  Created by Jérémy Perez on 06/07/2020.
//  Copyright © 2020 Jérémy Perez. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var locationLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentLocation()
    }
    
    func getCurrentLocation() {
        // Ask for authorisation from the user
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("location = \(locValue.latitude) \(locValue.longitude)")
        locationLabel.text = "location = \(locValue.latitude) longitude: \(locValue.longitude)"
    }
}
