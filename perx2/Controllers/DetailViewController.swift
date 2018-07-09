/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import Alamofire
import GoogleMaps
import SwiftyJSON
import GooglePlaces
import AlamofireImage
import MapKit
import CoreLocation
import Foundation
import UICircularProgressRing



class DetailViewController: UIViewController, CLLocationManagerDelegate,UITableViewDataSource,UITableViewDelegate  {
  
  @IBOutlet weak var detailDescriptionLabel: UILabel!
  @IBOutlet weak var CompanyImageView: UIImageView!
    var jsonArray:NSMutableArray?
    var newArray: Array<String> = []
    var locationManager: CLLocationManager!
    let key = "AIzaSyAolG3inckmIjxYvCipxdOUe06pccehNCs"
    @IBOutlet weak var locationsTableView: UITableView!
    //networking
    
    lazy var googleClient: GoogleClientRequest = GoogleClient()
    //location
    var currentLocation: CLLocation = CLLocation(latitude: 39.959185122763195, longitude: -75.16160762910337)
    var locationName : String = "Starbucks"
    var searchRadius : Int = 2500
  var responseText: String?
  var detailCompany: Company? {
    didSet {
      configureView()
    }

  }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        if let detailCompany = detailCompany {
            locationName = detailCompany.name!
            print("locations = \(locValue.latitude) \(locValue.longitude)")
            Alamofire.request("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(locValue.latitude),\(locValue.longitude)&radius=100&keyword=starbucks&key=\(key)").responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                print(swiftyJsonVar)
            }
            }
        }
    }
  
  func configureView() {
    if let detailCompany = detailCompany {
      if let detailDescriptionLabel = detailDescriptionLabel, let CompanyImageView = CompanyImageView {
        detailDescriptionLabel.text = detailCompany.name
        CompanyImageView.image = UIImage(named:detailCompany.name!)
        title = detailCompany.name!
    
      }
    }
  }
    func downloadLocations(contentID: String, completion: @escaping ([String]?) -> Void) {
      
        // 1
//        Alamofire.request("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=(LocValue.latitude),(yourlongitude)&radius=5000&keyword=starbucks&key=\(key)",
//                          parameters: ["content": contentID],
//                          headers: ["Authorization": "Basic xxx"])
//            // 2
//            .responseJSON { response in
//                guard response.result.isSuccess,
//                    let value = response.result.value else {
//                        print("Error while fetching tags: \(String(describing: response.result.error))")
//                        completion(nil)
//                        return
//                }
//
//                // 3
//                let tags = JSON(value)["results"][0]["tags"].array?.map { json in
//                    json["tag"].stringValue
//                }
//
//                // 4
//                completion(tags)
//        }
    }
  override func viewDidLoad() {
    super.viewDidLoad()
    let progressRing = UICircularProgressRing(frame: CGRect(x: 0, y: 0, width: 240, height: 240))
    // Change any of the properties you'd like
    progressRing.maxValue = 50
    progressRing.innerRingColor = UIColor.blue
    fetchGoogleData(forLocation: currentLocation)

   
    

    
    if (CLLocationManager.locationServicesEnabled())
    {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    

    configureView()
    
   
    
  }
    //Networking calls
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LocationsTableViewCell
        googleClient.getGooglePlacesData(forKeyword: (detailDescriptionLabel?.text)!, location: currentLocation, withinMeters: 2500) { (response) in
           
            cell.textLabel?.text = response.results[indexPath.row].name
            let locationName = response.results[indexPath.row]
            cell.addressLabel?.text = locationName.address
            cell.openLabel?.text = locationName.name
            
        }
            
        return cell
        
        
    }
    
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}


func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
    print("locations = \(locValue.latitude) \(locValue.longitude)")
    
}
//Networking calls
extension DetailViewController {
    func fetchGoogleData(forLocation: CLLocation) {
        //guard let location = currentLocation else { return }
        googleClient.getGooglePlacesData(forKeyword: "Starbucks", location: currentLocation, withinMeters: 2500) { (response) in
            
            self.printFirstFive(places: response.results)
            
        }
    }
    
    func printFirstFive(places: [Place]) {
        for place in places.prefix(5) {
            print("*******NEW PLACE********")
            let name = place.name
            let address = place.address
            let location = ("lat: \(place.geometry.location.latitude), lng: \(place.geometry.location.longitude)")
            guard let open = place.openingHours?.open  else {
                print("\(name) is located at \(address), \(location)")
                return
            }
            if open {
                print("\(name) is open, located at \(address), \(location)")
            } else {
                print("\(name) is closed, located at \(address), \(location)")
            }
        }
    }
}


