//
//  LocationHandler.swift
//  Final Challenge
//
//  Created by João Henrique Andrade on 28/10/20.
//  Copyright © 2020 João Henrique Andrade. All rights reserved.
//

import CoreLocation
import UIKit

final class LocationHandler: NSObject, CLLocationManagerDelegate{
    private override init(){}
    
    static let shared = LocationHandler()
    
    let locationHandler = CLLocationManager()
    var userLocation = CLLocation()
    
    func getUserLocation() -> UIAlertController?{
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined:
            locationHandler.requestWhenInUseAuthorization()
            return nil
            
        case .denied, .restricted:
            let alert = UIAlertController(title: "Location Services disabled", message: "Please enable Location Services in Settings", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            
            return alert
            
        case .authorizedAlways, .authorizedWhenInUse:
            break
            
        @unknown default:
            fatalError()
        }
        locationHandler.delegate = self
        locationHandler.startUpdatingLocation()
        return nil
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
            userLocation = currentLocation
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func getDistance(from coordinates:(Double, Double)) -> Double{
        let annoucementLocation = CLLocation(latitude: coordinates.0, longitude: coordinates.1)
        return annoucementLocation.distance(from: userLocation)
    }
}
