
import Foundation

func currentObservationAtLat(lat: Double, lon: Double) -> (locationName: String, currentTemperature: String) {
    let endpoint = NSURL(string: "http://forecast.weather.gov/MapClick.php?lat=\(lat)&lon=\(lon)&FcstType=json")
    let data = NSData(contentsOfURL: endpoint!)
    if let json: NSDictionary = JSONObjectWithData(data!) as? NSDictionary {
        if let currentObservationDictionary: NSDictionary = json["currentobservation"] as? NSDictionary {
            return ("\(currentObservationDictionary["name"]!)", "\(currentObservationDictionary["Temp"]!)º F")
        }
        else {
            return ("Location Unknown", "Temperature Unknown")
        }
    }
    else {
        return ("Location Unknown", "Temperature Unknown")
    }
}

private func JSONObjectWithData(data: NSData) -> AnyObject? {
    do { return try NSJSONSerialization.JSONObjectWithData(data, options: []) }
    catch { return .None }
}
