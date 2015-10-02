import UIKit
import CoreLocation

class CurrentWeatherViewController: UIViewController {

    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    var locationManger: LocationManager!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        locationManger = LocationManager.init { location in
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            
            self.updateWeatherLabel(latitude, lon: longitude)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationNameLabel.text = "Finding Weather"
        currentTemperatureLabel.text = ""
        loadingIndicator.startAnimating()
    }
    
    func updateWeatherLabel(lat:CLLocationDegrees, lon:CLLocationDegrees) -> () {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            let currentObservation = currentObservationAtLat(lat, lon: lon)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.locationNameLabel.text = currentObservation.locationName
                self.currentTemperatureLabel.text = currentObservation.currentTemperature
                self.loadingIndicator.stopAnimating()
            })
        }
    }
}

