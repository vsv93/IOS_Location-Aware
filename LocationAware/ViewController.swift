//
//  ViewController.swift
//  LocationAware
//
//  Created by Venkat on 21/02/17.
//  Copyright © 2017 vsv. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var latitideLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var courseLabel: UILabel!
    @IBOutlet var speedLabel: UILabel!
    @IBOutlet var altitudeLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    var locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userlocation = locations[0]
        
        self.latitideLabel.text = String(userlocation.coordinate.latitude)
        self.longitudeLabel.text = String(userlocation.coordinate.longitude)
        
        self.courseLabel.text = String(userlocation.course)
        
        self.speedLabel.text = String(userlocation.speed)
        
        self.altitudeLabel.text = String(userlocation.altitude)
        
        CLGeocoder().reverseGeocodeLocation(userlocation) { (placemarks, error) in
            
            if error != nil {
                
                print(error!)
                
            } else {
                
                if let placemark = placemarks?[0]{
                    
                    var address = ""
                    
                    if placemark.subThoroughfare != nil {
                        
                        address += placemark.subThoroughfare! + " "

                    }
                   
                    if placemark.thoroughfare != nil {
                        
                        address += placemark.thoroughfare! + "\n"
                        
                    }
                    
                    if placemark.subLocality != nil {
                        
                        address += placemark.subLocality! + "\n"
                        
                    }
                    
                    if placemark.subAdministrativeArea != nil {
                        
                        address += placemark.subAdministrativeArea! + "\n"
                        
                    }
                    
                    if placemark.postalCode != nil {
                        
                        address += placemark.postalCode! + "\n"
                        
                    }
                  
                    if placemark.country != nil {
                        
                       address += placemark.country!
                        
                    }
                    
                    self.addressLabel.text = address
                    
                }
            }
            
        }
    }


}

