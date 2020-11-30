//
//  branchCell.swift
//  mazayaApp
//
//  Created by Bassam Ramadan on 11/27/20.
//  Copyright © 2020 Bassam Ramadan. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
class branchCell: UITableViewCell , CLLocationManagerDelegate{
    @IBOutlet var phone: UILabel!
    @IBOutlet var fax: UILabel!
    @IBOutlet var plus: UIButton!
    @IBOutlet var call: UIButton!
    @IBOutlet var sectionName: UILabel!
    @IBOutlet var branchstack: UIStackView!
    
    // MARk:- Map
    let geocoder = GMSGeocoder()
    @IBOutlet var mapView: GMSMapView!
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
    // An array to hold the list of likely places.
    var likelyPlaces: [GMSPlace] = []
    let marker = GMSMarker()
    // The currently selected place.
    var selectedPlace: GMSPlace?
    var long:Double?
    var lat:Double?
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let userLocation = locations.last
        
        showMarker(position: userLocation!.coordinate)
        self.locationManager.stopUpdatingLocation()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
       
    }
    func setupData(dataCell: branchData,row: Int,isAppear: Bool){
        branchstack.isHidden = isAppear
        plus.tag = row
        call.tag = row
        sectionName.text = dataCell.name ?? ""
        phone.text = dataCell.phone ?? ""
        fax.text = dataCell.fax ?? ""
        if isAppear{
            plus.setImage(#imageLiteral(resourceName: "ic_plus"), for: .normal)
        }else{
            plus.setImage(#imageLiteral(resourceName: "ic_minus"), for: .normal)
        }
        lat = Double(dataCell.lat ?? "0")
        long = Double(dataCell.lon ?? "0")
        mapView.delegate = self
        let camera = GMSCameraPosition.camera(withLatitude: lat ?? 21.555940, longitude: long ?? 39.194628, zoom: 16.0)
        mapView.camera = camera
        showMarker(position: camera.target)
    }
}
extension branchCell: GMSMapViewDelegate{
    func showMarker(position: CLLocationCoordinate2D){
        
        self.long = position.longitude
        self.lat = position.latitude
        geocoder.reverseGeocodeCoordinate(position) { (response, error) in
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
            self.marker.position = position
            self.marker.title = lines.joined(separator: "\n")
            self.marker.map = self.mapView
            //    self.addressOnMap.text = lines.joined(separator: "\n")
        }
    }
    
    @IBAction func gpsAction(_ sender: Any){
        self.mapView.isMyLocationEnabled = true
        //Location Manager code to fetch current location
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = 1.0
    }
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            // Show alert letting the user know they have to turn this on.
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .denied , .restricted , .authorizedAlways:
            print("denied")
        @unknown default:
            print("default")
        }
    }
}
