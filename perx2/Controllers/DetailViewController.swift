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



class DetailViewController: UIViewController, CLLocationManagerDelegate {
  
  @IBOutlet weak var detailDescriptionLabel: UILabel!
  @IBOutlet weak var CompanyImageView: UIImageView!
  @IBOutlet weak var tableView: UITableView!
    var jsonArray:NSMutableArray?
    var newArray: Array<String> = []
    var locationManager: CLLocationManager!
    let key = "AIzaSyAolG3inckmIjxYvCipxdOUe06pccehNCs"
  
  var responseText: String?
  var detailCompany: Company? {
    didSet {
      configureView()
    }

  }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
  
  func configureView() {
    if let detailCompany = detailCompany {
      if let detailDescriptionLabel = detailDescriptionLabel, let CompanyImageView = CompanyImageView {
        detailDescriptionLabel.text = detailCompany.category
        CompanyImageView.image = UIImage(named:detailCompany.name!)
        title = detailCompany.name
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
    
    Alamofire.request("http://api.androidhive.info/contacts/").responseJSON { (responseData) -> Void in
        if((responseData.result.value) != nil) {
            let swiftyJsonVar = JSON(responseData.result.value!)
            print(swiftyJsonVar)
        }
    }
    
//    Alamofire.request(.GET, "https://rocky-meadow-1164.herokuapp.com/todo") .responseJSON { response in
//        print(response.request)  // original URL request
//        print(response.response) // URL response
//        print(response.data)     // server data
//        print(response.result)   // result of response serialization
//
//        if let JSON = response.result.value {
//            self.jsonArray = JSON as? NSMutableArray
//            for item in self.jsonArray! {
//                print(item["name"]!)
//                let string = item["name"]!
//                print("String is \(string!)")
//
//                self.newArray.append(string! as! String)
//            }
//
//            print("New array is \(self.newArray)")
//
//            self.tableView.reloadData()
//        }
//    }
    
    

    
    if (CLLocationManager.locationServicesEnabled())
    {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
//    Alamofire.request(.GET, "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=39.9592474,-75.1614925&radius=5000&keyword=starbucks&key=AIzaSyAolG3inckmIjxYvCipxdOUe06pccehNCs").responseJSON { response in // 1
//        print(response.request)  // original URL request
//        print(response.response) // URL response
//        print(response.data)     // server data
//        print(response.result)   // result of response serialization
//
//        if let JSON = response.result.value {
//            print("JSON: \(JSON)")
//        }
//    }
    configureView()
    
    // Ask for Authorisation from the User.
   
    
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
}
func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
    print("locations = \(locValue.latitude) \(locValue.longitude)")
    
}

