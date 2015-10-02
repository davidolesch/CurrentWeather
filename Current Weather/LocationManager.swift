import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    var didUpdateLocation : ((CLLocation) -> Void)?
    private let manager = CLLocationManager()
    
    convenience init(block: ((CLLocation) -> Void)?) {
        self.init()
        manager.delegate = self
        didUpdateLocation = block
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            manager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        manager.requestLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("location manager error: \(error)")
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        didUpdateLocation!(locations.first!)
    }
}