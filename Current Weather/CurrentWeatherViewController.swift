import UIKit

class CurrentWeatherViewController: UIViewController {

    @IBOutlet weak var locationNameLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    let lat = 30.2436699
    let lon = -97.7268667
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationNameLabel.text = "Finding Weather"
        currentTemperatureLabel.text = ""
        loadingIndicator.startAnimating()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let priority = DISPATCH_QUEUE_PRIORITY_DEFAULT
        dispatch_async(dispatch_get_global_queue(priority, 0)) {
            let currentObservation = currentObservationAtLat(self.lat, lon: self.lon)
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.locationNameLabel.text = currentObservation.locationName
                self.currentTemperatureLabel.text = currentObservation.currentTemperature
                self.loadingIndicator.stopAnimating()
            })
        }
    }
    
}

