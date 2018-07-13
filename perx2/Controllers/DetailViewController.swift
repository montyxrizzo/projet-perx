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
    @IBOutlet weak var locationsTableView: UITableView!
    @IBOutlet weak var progressRing: UICircularProgressRing!
    var CompanyObs:LocationsWrapper?
    
    var response: GooglePlacesResponse? {
        didSet {
            refreshUI()

        }
    }
    var likelyPlaces: [GooglePlacesResponse] = []
    var selectedPlace: GooglePlacesResponse?
  @IBOutlet weak var detailDescriptionLabel: UILabel!
  @IBOutlet weak var CompanyImageView: UIImageView!
    var jsonArray:NSMutableArray?
    var newArray: Array<String> = []
    var locationManager: CLLocationManager!
    let key = "AIzaSyAolG3inckmIjxYvCipxdOUe06pccehNCs"
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
        let _ = googleClient.getGooglePlacesData(forKeyword: detailCompany.name!, location: currentLocation, withinMeters: 2500){ (response) in
            }
        }
        
    
      }
    }
  
   
    
  override func viewDidLoad() {
    super.viewDidLoad()
    locationsTableView.delegate = self
    locationsTableView.dataSource = self
   
    

    configureView()
    
  }
//    override func viewWillAppear(){
//        UIView.animate(withDuration: 10.0){
//            self.progressRing.value = 60
//        }
//    }


    func refreshUI() {
        loadViewIfNeeded()
        
    }
    //Networking calls
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return GooglePlacesResponse().count
//        gross hack
        return 3
    }
    
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LocationsTableViewCell
//        let collectionItem = likelyPlaces[indexPath.row]
        googleClient.getGooglePlacesData(forKeyword: (detailDescriptionLabel?.text)!, location: currentLocation, withinMeters: 2500) { (response) in
            
            cell.textLabel?.text = "test"
            let locationName = "Test"
            cell.addressLabel?.text = "Test"
            cell.openLabel?.text = "Test"
//            cell.textLabel?.text = response.results[indexPath.row].name
//            let locationName = response.results[indexPath.row]
//            cell.addressLabel?.text = locationName.address
//            cell.openLabel?.text = locationName.name
            
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
    
    
//
//    private class func locationsArrayFromResponse(_ response: DataResponse<Any>) -> Result<LocationsWrapper> {
//        guard response.result.error == nil else {
//            // got an error in getting the data, need to handle it
//            print(response.result.error!)
//            return .failure(response.result.error!)
//        }
//
//        // make sure we got JSON and it's a dictionary
//        guard let json = response.result.value as? [String: Any] else {
//            print("didn't get locations object as JSON from API")
//        }
//
//        let wrapper:LocationsWrapper = LocationsWrapper()
//        wrapper.count = json["count"] as? Int
//
//        var allLocations: [Place] = []
//        if let results = json["results"] as? [[String: Any]] {
//            for jsonLocations in results {
//                let locations = Place()
//                allLocations.append(locations)
//            }
//        }
//        wrapper.companies = allLocations
//        return .success(wrapper)
//    }
//

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




